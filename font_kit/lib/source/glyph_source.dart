import 'package:collection/collection.dart';

abstract interface class GlyphSource {
  String get glyphs;
}

/// `label` getter만 사용하는 경우에 재사용할 수 있는 추상 믹스인
mixin GlyphLabelMixin implements GlyphSource {
  String get label;

  @override
  String get glyphs {
    return label;
  }
}

class GlyphBuffer<T> extends DelegatingList<T> implements GlyphSource {
  const GlyphBuffer(super.base);

  @override
  String get glyphs {
    return join();
  }
}

class GlyphTree<T extends GlyphSource> extends DelegatingList<T> implements GlyphSource {
  const GlyphTree(super.base);

  @override
  String get glyphs {
    return map((element) => element.glyphs).join();
  }
}