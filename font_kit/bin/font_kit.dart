import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:collection/collection.dart';
import 'package:font_kit/src/constraint.dart';
import 'package:font_kit/src/project.dart';
import 'package:font_kit/src/source/glyph_source.dart';
import 'package:font_kit/src/source/markdown_text_glyph.dart';
import 'package:path/path.dart' as path;

/// 폰트 서브셋 생성 시 적용할 fontTools 옵션들
const List<String> _fontToolsOptions = [
  '--unicodes=U+0020-007E', // 기본 ASCII 범위 (숫자, 영문, 특수기호)
  '--layout-features=*',    // 커닝, 합자 등 디자인 기능 유지
  '--glyph-names',          // 글리프 이름 유지
  '--symbol-cmap',          // 심볼 매핑 유지
  '--legacy-cmap',          // 구형 시스템 호환성
  '--notdef-glyph',         // .notdef 글리프 유지
  '--notdef-outline',       // .notdef 외곽선 유지
  '--recommended-glyphs',   // 필수 글리프 유지
  '--name-IDs=*',           // 메타데이터(저작권 등) 유지
  '--name-legacy',          // 레거시 이름 유지
  '--name-languages=*',     // 다국어 이름 정보 유지
  // '--flavor=woff2',         // WOFF2 압축 (웹 최적화)
];

/// Python 프로세스 실행 시 환경 변수 (인코딩)
const Map<String, String> _pythonEnvironment = {
  'PYTHONUTF8': '1',          // Python 3.7+ UTF-8 모드 강제
  'PYTHONIOENCODING': 'utf-8', // 입출력 인코딩 강제
  'LANG': 'en_US.UTF-8',       // 로케일 설정
};

Future<void> main(List<String> arguments) async {
  final ArgParser parser = _buildArgParser();
  File? tempTextFile;

  try {
    final ArgResults results = parser.parse(arguments);
    final String inputPath = results['input'] as String;
    final String outputPath = results['output'] as String;

    final String uniqueChars = _collectUniqueCharacters();
    tempTextFile = await _createTempTextFile(uniqueChars);

    await _runPyftsubset(
      inputPath: inputPath,
      outputPath: outputPath,
      textFilePath: tempTextFile.path,
    );

  } catch (e) {
    stderr.writeln('\n 에러 발생: $e');
    exit(1);
  } finally {
    if (tempTextFile != null && await tempTextFile.exists()) {
      await tempTextFile.delete();
    }
  }
}

ArgParser _buildArgParser() {
  return ArgParser()
    ..addOption(
      'input',
      abbr: 'i',
      mandatory: true,
      help: '원본 폰트 파일 경로 (.ttf, .otf)',
    )
    ..addOption(
      'output',
      abbr: 'o',
      mandatory: true,
      help: '저장할 결과 파일 경로',
    );
}

String _collectUniqueCharacters() {
  final GlyphTree glyphTree = GlyphTree([
    const MarkdownTextGlyph(),
    ...Project.values,
    ...Constraints.values,
  ]);

  return glyphTree.glyphs.runes
      .map(String.fromCharCode)
      .toSet()
      .sorted()
      .join();
}

/// 시스템 임시 디렉토리에 텍스트 파일 생성 (UTF-8 인코딩)
Future<File> _createTempTextFile(String content) async {
  final String tmpPath = 'font_kit_subset_';
  final Directory tempDir = await Directory.systemTemp.createTemp(tmpPath);
  final File file = File(path.join(tempDir.path, 'chars.txt'));

  return await file.writeAsString(content, encoding: utf8);
}

/// Python fontTools 프로세스 실행
Future<void> _runPyftsubset({
  required String inputPath,
  required String outputPath,
  required String textFilePath,
}) async {
  final String pythonCommand = Platform.isWindows ? 'python' : 'python3';

  final ProcessResult result = await Process.run(
    pythonCommand,
    [
      '-m', 'fontTools.subset',
      inputPath,
      '--output-file=$outputPath',
      '--text-file=$textFilePath', // --text 대신 파일 경로 전달
      ..._fontToolsOptions,
    ],
    runInShell: true,
    // [중요] Python 환경 변수 주입 (UTF-8 강제)
    environment: {
      ...Platform.environment, // 기존 환경 변수 유지
      ..._pythonEnvironment,   // UTF-8 설정 덮어쓰기
    },
  );

  if (result.exitCode != 0) {
    throw Exception('fontTools 실행 실패 (Exit Code: ${result.exitCode})\n${result.stderr}');
  }
}