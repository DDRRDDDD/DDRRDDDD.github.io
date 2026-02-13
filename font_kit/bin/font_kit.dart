import './src/arguments.dart';
import './src/font_tool.dart';

Future<void> main(List<String> args) async {
  final Arguments arguments = Arguments.from(args);

  await FontTool
      .fromType(arguments.type)
      .process(arguments.inputPath, arguments.outputPath);
}
