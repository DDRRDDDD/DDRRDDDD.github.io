import 'package:flutter/services.dart';

class FontManager {
  static const String notoSansFamily = 'NotoSans';

  /// `font_kit`에서 폰트 서브셋(WOFF2) 변환으로 생성되는 경로.
  static const String _fontAssetPath = 'assets/fonts/NotoSansKR-VariableFont_wght.ttf';

  static Future<void> load() async {
    final FontLoader fontLoader = FontLoader(notoSansFamily);
    fontLoader.addFont(rootBundle.load(_fontAssetPath));
    await fontLoader.load();
  }
}