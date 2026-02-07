abstract interface class GlyphSource {
  Set<String> get textForSubset;

  static String combineTextGlyphs() {
    return '';
  }
}