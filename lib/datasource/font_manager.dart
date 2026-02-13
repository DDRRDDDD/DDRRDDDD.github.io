import 'package:flutter/services.dart';

class FontManager {
  static const String notoSansFamily = 'NotoSans';
  static const String notoSansEmojiFamily = 'NotoSansEmoji';
  static const String jetBrainsMonoFamily = 'JetBrainsMono';

  static Future<void> load() async {
    Future.wait([
      _createFontLoader(
        fontFamily: notoSansFamily,
        assetPath: 'assets/fonts/NotoSansKR-VariableFont_wght.ttf',
      ),
      _createFontLoader(
        fontFamily: notoSansEmojiFamily,
        assetPath: 'assets/fonts/NotoColorEmoji-Regular.ttf',
      ),
      _createFontLoader(
        fontFamily: jetBrainsMonoFamily,
        assetPath: 'assets/fonts/JetBrainsMono-Medium.ttf',
      ),
    ]);
  }

  static Future<FontLoader> _createFontLoader({
    required String fontFamily,
    required String assetPath,
  }) async {
    final FontLoader fontLoader = FontLoader(fontFamily);
    return fontLoader..addFont(rootBundle.load(assetPath));
  }
}
