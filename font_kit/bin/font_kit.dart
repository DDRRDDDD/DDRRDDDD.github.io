import 'package:args/args.dart';
import 'package:font_kit/constraint.dart';
import 'package:font_kit/source/glyph_source.dart';
import 'package:font_kit/project.dart';
import 'package:font_kit/source/markdown_text_glyph.dart';

final ArgParser argParser = ArgParser()
  ..addOption(
    'input',
    mandatory: true,
    abbr: 'i',
  )
  ..addOption(
    'output',
    mandatory: true,
    abbr: 'o',
  );

final List<String> systemArgs = [
  // --- 폰트 품질/호환성 유지 옵션 (안전 장치) ---
  '--unicodes=U+0020-007E', // 숫자, 영문, 특수기호 전체 포함
  '--layout-features=*', // 커닝(자간), 합자 등 폰트의 디자인 기능 유지
  '--glyph-names', // 글리프 내부 이름 유지 (PDF 복사/붙여넣기 호환성)
  '--symbol-cmap', // 심볼 문자 매핑 유지 (특수문자 호환성)
  '--legacy-cmap', // 구형 시스템용 레거시 매핑 유지 (오래된 OS 호환)
  '--notdef-glyph', // .notdef(정의되지 않음) 글리프 데이터 유지
  '--notdef-outline', // .notdef의 네모 박스(□) 모양 유지 (깨짐 확인용)
  '--recommended-glyphs', // 폰트 표준상 필수인 글리프 4종(null, CR 등) 강제 유지
  '--name-IDs=*', // 폰트의 모든 메타데이터(저작권, 제작자, 버전 등) 유지
  '--name-legacy', // 구형 플랫폼용 폰트 이름 정보 유지
  '--name-languages=*', // 폰트 이름에 포함된 다국어 정보(한글명/영문명 등) 모두 유지
];

final GlyphTree<GlyphSource> glyphSet = GlyphTree([
  ...Project.values,
  ...Constraints.values,
  MarkdownTextGlyph(),
]);

void main(List<String> arguments) async {
  // final ArgResults result = argParser.parse(arguments);
  // final String inputPath = result['input'] as String;
  // final String outputPath = result['output'] as String;
  //
  // String textData = GlyphSource.joinedText([]); // TODO 글리프 채우기
  //
  // try {
  //   final ProcessResult process = await Process.run(
  //     'pyftsubset',
  //     [
  //       inputPath,
  //       '--output-file=$outputPath',
  //       '--text=$textData',
  //       ...systemArgs,
  //     ],
  //     runInShell: true,
  //   );
  //
  //   if (process.exitCode != 0) {
  //     stderr.writeln('Error: ${process.stderr}');
  //     exit(process.exitCode);
  //   }
  //
  // } catch (e) {
  //   stderr.writeln('Execution Error: $e');
  //   exit(1);
  // }
  // MarkdownSet().glyphs;
  print(Project.myPortfolio.glyphs);
}
