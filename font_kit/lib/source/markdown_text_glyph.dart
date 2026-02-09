import 'dart:io';
import 'package:path/path.dart' as path;

import 'glyph_source.dart';

class MarkdownTextGlyph implements GlyphSource {
  static const String _directoryPath = '../assets/md/';

  const MarkdownTextGlyph();

  @override
  String get glyphs {
    final directory = Directory(_directoryPath);

    if (!directory.existsSync()) {
      stderr.writeln('디렉토리를 찾을 수 없습니다: ${directory.absolute.path}');
      return '';
    }

    return directory
        .listSync(recursive: true)
        .whereType<File>()
        .where(_isMarkdownExtension)
        .fold(StringBuffer(), _combineCharacters)
        .toString();
  }

  bool _isMarkdownExtension(File file) {
    return path.extension(file.path).toLowerCase() == '.md';
  }

  StringBuffer _combineCharacters(StringBuffer buffer, File file) {
    try {
      final String fileName = path.basenameWithoutExtension(file.path);
      final String content = file.readAsStringSync();

      buffer.write(fileName);
      buffer.write(content);
    } catch (e) {
      stderr.writeln('읽기 실패: ${file.path}');
      rethrow;
    }

    return buffer;
  }
}