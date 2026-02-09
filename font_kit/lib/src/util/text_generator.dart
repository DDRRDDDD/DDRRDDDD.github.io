import '../source/glyph_source.dart';

/// 함수형 정의를 위한 클래스
abstract class TextGenerator implements GlyphSource {
  const TextGenerator();

  String generate();

  @override
  String get glyphs {
    return generate();
  }

  @override
  String toString() {
    return generate();
  }
}

class PeriodText extends TextGenerator {
  final String startAt;
  final String? endAt;

  const PeriodText([this.startAt = '', this.endAt]);

  @override
  String generate() {
    return '$startAt ~ ${endAt ?? '진행 중'}';
  }
}

class TeamSummaryText extends TextGenerator {
  final int count;
  final String team;

  const TeamSummaryText([this.count = 0, this.team = '']);

  @override
  String generate() {
    return '총 $count명 ($team)';
  }
}

class ContributionText extends TextGenerator {
  final int percent;

  const ContributionText([this.percent = 0]);

  @override
  String generate() {
    return '기여도 $percent%';
  }
}