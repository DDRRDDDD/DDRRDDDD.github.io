import 'dart:async';
import 'dart:io';

import './arguments.dart';
import './text_mixin.dart';

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

  String get command => Platform.isWindows ? 'python' : 'python3';

  Future<void> _process(String inputPath, String outputPath);

  void _dispose() {}

  Future<void> process(String inputPath, String outputPath) async {
    try {
      await _process(inputPath, outputPath);
    } catch (exception) {
      _onProcessError(exception);
    } finally {
      _dispose();
    }
  }

  void _onProcessError(Object exception) {
    stderr.writeln('작업 중 치명적 에러 발생: $exception');
    exit(1);
  }

  /// 프로세스 실행 결과가 실패(exitCode != 0)일 경우 로그 파일을 생성합니다.
  Future<void> _handleProcessResult(ProcessResult result, List<String> args) async {
    if (result.exitCode == 0) return;

    final String timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final String logFileName = 'font_tool_error_$timestamp.log';

    final logContent = StringBuffer()
      ..writeln('--- FontTool Error Log ---')
      ..writeln('Time: ${DateTime.now()}')
      ..writeln('Command: $command ${args.join(' ')}')
      ..writeln('Exit Code: ${result.exitCode}')
      ..writeln('\n[STDOUT]\n${result.stdout}')
      ..writeln('\n[STDERR]\n${result.stderr}');

    try {
      final logFile = File(logFileName);
      await logFile.writeAsString(logContent.toString());
      stderr.writeln('\n에러 발생! 로그 파일이 생성되었습니다: ${logFile.absolute.path}');
    } catch (e) {
      stderr.writeln('로그 파일 작성 실패: $e');
    }

    // 에러 발생 시 프로세스 종료
    exit(result.exitCode);
  }
}

class Woff2Compressor extends FontTool {
  @override
  Future<void> _process(String inputPath, String outputPath) async {
    final args = [
      '-m', 'fontTools.ttLib.woff2', 'compress',
      '-o', outputPath,
      inputPath,
    ];

    final result = await Process.run(command, args, runInShell: true);
    await _handleProcessResult(result, args);
  }
}

class FontSubsetProcessor extends FontTool with TextFileMixin, GlyphTextMixin {
  final SubsetMode mode;

  FontSubsetProcessor(this.mode);

  @override
  Future<void> _process(String inputPath, String outputPath) async {
    final String content = switch(mode) {
      SubsetMode.textOnly => textGlyphs,
      SubsetMode.emojiOnly => emojiGlyphs,
    };

    final File textFile = await writeTempFile(content);

    final args = [
      '-m', 'fontTools.subset',
      inputPath,
      '--output-file=$outputPath',
      '--text-file=${textFile.path}',
      ..._fontToolsOptions,
    ];

    final result = await Process.run(command, args, runInShell: true);
    await _handleProcessResult(result, args);
  }

  @override
  void _dispose() {
    cleanUp();
  }
}

enum SubsetMode { textOnly, emojiOnly }