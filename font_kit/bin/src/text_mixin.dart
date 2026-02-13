import 'dart:convert';
import 'dart:io';

import 'package:characters/characters.dart';
import 'package:collection/collection.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:font_kit/font_kit.dart';
import 'package:font_kit/src/source/glyph_source.dart';
import 'package:font_kit/src/source/markdown_text_glyph.dart';

mixin class GlyphTextMixin {
  static final EmojiParser emojiParser = EmojiParser(init: true);

  static final GlyphSource source = GlyphTree([
    const MarkdownTextGlyph(),
    ...Constraints.values,
    ...Project.values,
  ]);

  String get textGlyphs {
    return source.glyphs.characters
        .whereNot(emojiParser.hasEmoji)
        .toSet()
        .sorted()
        .join();
  }

  String get emojiGlyphs {
    return source.glyphs.characters
        .where(emojiParser.hasEmoji)
        .toSet()
        .sorted()
        .join();
  }
}

mixin class TextFileMixin {
  File? _tempFile;

  Future<File> writeTempFile(String content) async {
    await cleanUp();

    final Directory tempDir = await Directory.systemTemp.createTemp('font_kit_');
    final File file = File('${tempDir.path}/chars.txt');

    return _tempFile = await file.writeAsString(content, encoding: utf8);
  }

  Future<void> cleanUp() async {
    await _tempFile?.parent.delete(recursive: true);
    _tempFile = null;
  }
}
