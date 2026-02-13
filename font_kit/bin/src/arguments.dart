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
        allowedHelp: {
          ProcessType.text.name: '텍스트(한글/영어/기호)만 남기고 이모지는 제거한 서브셋 생성',
          ProcessType.emoji.name: '이모지만 남기고 일반 텍스트는 제거한 서브셋 생성',
          ProcessType.compress.name: '글자 삭제 없이 단순 WOFF2 압축 변환 (주의: 파일 용량이 클수록 변환 시간이 매우 오래 걸릴 수 있음)',
        },
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
