import 'package:flutter/services.dart';

class FontManager {
  static const String notoSansFamily = 'NotoSans';
  static const String notoSansEmojiFamily = 'NotoSansEmoji';
  static const String jetBrainsMonoFamily = 'JetBrainsMono';

  static Future<void> load() async {
    await Future.wait([
      _registerFont(
        fontFamily: notoSansFamily,
        assetPath: 'assets/fonts/NotoSansKR-VariableFont_wght.ttf',
      ),
      _registerFont(
        fontFamily: notoSansEmojiFamily,
        assetPath: 'assets/fonts/NotoColorEmoji-Regular.ttf',
      ),
      _registerFont(
        fontFamily: jetBrainsMonoFamily,
        assetPath: 'assets/fonts/JetBrainsMono-Medium.ttf',
      ),
    ]);
  }

  static Future<void> _registerFont({
    required String fontFamily,
    required String assetPath,
  }) async {
    final FontLoader fontLoader = FontLoader(fontFamily);

    fontLoader.addFont(rootBundle.load(assetPath));
    await fontLoader.load();
  }
}
