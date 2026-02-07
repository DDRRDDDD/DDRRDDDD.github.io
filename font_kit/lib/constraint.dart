import 'glyph_source.dart';

enum Constraints implements GlyphSource {
  inProgress('진행 중');
  ///...

  final String label;

  const Constraints(this.label);

  @override
  Set<String> get textForSubset {
    return {label};
  }
}