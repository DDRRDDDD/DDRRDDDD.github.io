import './src/arguments.dart';
import './src/font_tool.dart';

void main(List<String> args) {
  final Arguments arguments = Arguments.from(args);

  FontTool
      .fromType(arguments.type)
      .process(arguments.inputPath, arguments.outputPath);
}
