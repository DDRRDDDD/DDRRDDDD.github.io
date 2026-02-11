import 'package:flutter/services.dart';

class FontManager {
  static const String notoSansFamily = 'NotoSans';

  static const String _fontAssetPath = 'assets/fonts/NotoSansKR-VariableFont_wght.ttf';

  static Future<void> load() async {
    final FontLoader fontLoader = FontLoader(notoSansFamily);
    fontLoader.addFont(rootBundle.load(_fontAssetPath));
    await fontLoader.load();
  }
}