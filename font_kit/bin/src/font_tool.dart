import 'dart:async';
import 'dart:io';

import './arguments.dart';
import './text_file.dart';

/// 폰트 서브셋 생성 시 적용할 fontTools 옵션들
const List<String> _fontToolsOptions = [
  // '--unicodes=U+0020-007E', // 기본 ASCII 범위 (숫자, 영문, 특수기호)
  '--layout-features=*', // 커닝, 합자 등 디자인 기능 유지
  '--layout-scripts=*', // 디자인 스크립트 유지
  '--glyph-names', // 글리프 이름 유지
  '--symbol-cmap', // 심볼 매핑 유지
  '--legacy-cmap', // 구형 시스템 호환성
  '--notdef-glyph', // .notdef 글리프 유지
  '--notdef-outline', // .notdef 외곽선 유지
  '--recommended-glyphs', // 필수 글리프 유지
  '--name-IDs=*', // 메타데이터(저작권 등) 유지
  '--name-legacy', // 레거시 이름 유지
  '--name-languages=*', // 다국어 이름 정보 유지
  '--flavor=woff2', // WOFF2 압축 (웹 최적화)
];

abstract class FontTool {
  const FontTool();

  factory FontTool.fromType(ProcessType type) {
    return switch (type) {
      ProcessType.text => FontSubsetProcessor(SubsetMode.textOnly),
      ProcessType.emoji => FontSubsetProcessor(SubsetMode.emojiOnly),
      ProcessType.compress => Woff2Compressor(),
    };
  }

  String get command {
    return Platform.isWindows ? 'python' : 'python3';
  }

  Future<int> _process(String inputPath, String outputPath);

  void _dispose() {}

  void process(String inputPath, String outputPath) {
    try {
      _process(inputPath, outputPath).then(exit);
    } catch (exception) {
      stderr.writeln('\n 에러 발생: $exception');
      exit(1);
    } finally {
      _dispose();
    }
  }
}

/// 파일을 그냥 .woff2로 변환
class Woff2Compressor extends FontTool {
  @override
  Future<int> _process(String inputPath, String outputPath) async {
    return Process.run(
      runInShell: true,
      command,
      [
        '-m',
        'fontTools.ttLib.woff2',
        'compress',
        '-o',
        outputPath,
        inputPath,
      ],
    ).then((result) {
      return result.exitCode;
    });
  }
}

/// 이모지 or 일반 텍스트 서브셋 프로세스
class FontSubsetProcessor extends FontTool with TextFileMixin {
  final SubsetMode mode;

  FontSubsetProcessor(this.mode);

  @override
  Future<int> _process(String inputPath, String outputPath) async {
    final String content = '';
    final File textFile = await writeTempFile(content);

    return Process.run(
      runInShell: true,
      command,
      [
        '-m',
        'fontTools.subset',
        inputPath,
        '--output-file=$outputPath',
        '--text-file=${textFile.path}',
        ..._fontToolsOptions,
      ],
    ).then((result) {
      return result.exitCode;
    });
  }

  String textFilepath() {
    return '';
  }

  @override
  void _dispose() {
    unawaited(cleanUp());
  }
}

enum SubsetMode { textOnly, emojiOnly }
