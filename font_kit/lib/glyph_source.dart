abstract interface class GlyphSource {
  String get textForSubset;
}

/// Enum에서 `label` getter만 사용하는 경우에 재사용할 수 있는 추상 믹스인
mixin GlyphLabelMixin on Enum implements GlyphSource {
  String get label;

  @override
  String get textForSubset => label;
}

/// 함수형 정의를 위한 클래스
abstract class TextGenerator implements GlyphSource {
  const TextGenerator();
  
  String generate();

  @override
  String get textForSubset {
    return generate();
  }
}