abstract interface class GlyphSource {
  Set<String> get textForSubset;

  static String joinedText(List<GlyphSource> sources) {
    return sources.expand((e) => e.textForSubset).toSet().join();
  }
}

/// 함수형 정의를 위한 클래스
abstract class TextGenerator implements GlyphSource {
  const TextGenerator();
  
  String generate();

  @override
  Set<String> get textForSubset {
    return generate().split('').toSet();
  }
}