import 'package:args/args.dart';

const String kInput = 'input';
const String kOutput = 'output';
const String kType = 'type';

class Arguments {
  final String inputPath;
  final String outputPath;
  final ProcessType type;

  const Arguments({
    required this.inputPath,
    required this.outputPath,
    required this.type,
  });

  static ArgParser get argParser {
    return ArgParser()
      ..addOption(
        kInput,
        abbr: 'i',
        mandatory: true,
        help: '원본 폰트 파일 경로 (.ttf, .otf)',
      )
      ..addOption(
        kOutput,
        abbr: 'o',
        mandatory: true,
        help: '저장할 결과 파일 경로',
      )
      ..addOption(
        kType,
        abbr: 't',
        defaultsTo: ProcessType.text.name,
        allowed: ProcessType.values.map((e) => e.name).toList(),
        help: '프로세스 타입',
      );
  }

  factory Arguments.from(List<String> args) {
    final ArgResults results = argParser.parse(args);

    return Arguments(
      inputPath: results[kInput] as String,
      outputPath: results[kOutput] as String,
      type: ProcessType.values.byName(results[kType] as String),
    );
  }
}

enum ProcessType {
  text,        // 텍스트 위주 서브셋
  emoji,       // 이모지 위주 서브셋
  compress,    // 단순 WOFF2 변환
}
