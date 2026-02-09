import 'package:recase/recase.dart';

import 'source/glyph_source.dart';

enum ProjectIcon {
  smartphone,
  flag,
  code,
  apple,
  github,
}

enum ProjectType with GlyphLabelMixin implements GlyphSource {
  main('Main Project'),
  sub('Sub Project')
  ;

  @override
  final String label;

  const ProjectType(this.label);
}

enum Project implements GlyphSource {
  oneHour(
    primaryIcon: ProjectIcon.smartphone,
    type: ProjectType.main,
    title: '원아워',
    subTitle: '이웃과 소소한 모임부터 대화까지',
    description: '시간 남을 때 근처 사람과 가볍게 만날 수 있는 \n번개 모임 및 이웃 연결 대화 서비스',
    labels: GlyphBuffer(['Flutter', 'Firebase', 'Riverpod']),
    bannerAssetPath: 'assets/image/one-hour.jpg',
    role: '클라이언트 개발',
    startAt: '2024.12',
    endAt: '2025.02',
    myContribution: 0.3,
    teamSummaries: GlyphBuffer(['기획·Flutter', 'Flutter']),
    references: GlyphTree([
      LinkItem(
        icon: ProjectIcon.apple,
        label: 'App Store',
        url:
        'https://apps.apple.com/kr/app/'
            '%EC%9B%90%EC%95%84%EC%9B%8C-'
            '%EC%9D%B4%EC%9B%83%EA%B3%BC-'
            '%EC%86%8C%EC%86%8C%ED%95%9C-'
            '%EB%AA%A8%EC%9E%84%EB%B6%80%ED%84%B0-'
            '%EB%8C%80%ED%99%94%EA%B9%8C%EC%A7%80/id6739973696',
      ),
    ]),
  ),
  myTurn(
    primaryIcon: ProjectIcon.flag,
    type: ProjectType.main,
    title: '마이턴',
    subTitle: '보드게임 모임 플랫폼',
    description: '\'원아워\'의 피벗 프로젝트,\n모임의 규모를 보드게임으로 집중한 애플리케이션',
    labels: GlyphBuffer(['Flutter', 'Supabase', 'Riverpod', 'GoRouter']),
    bannerAssetPath: 'assets/image/my-turn.jpg',
    role: '앱 개발 리드',
    startAt: '2025.07',
    endAt: '2025.12',
    myContribution: 0.9,
    teamSummaries: GlyphBuffer(['디자이너', '기획', '개발']),
  ),
  myPortfolio(
    primaryIcon: ProjectIcon.code,
    type: ProjectType.sub,
    subTitle: '플러터 포트폴리오 웹사이트',
    labels: GlyphBuffer(['Flutter', 'GoRouter', 'Forge2D', 'Rive']),
    role: '1인 전담 개발 (기획·디자인·구현)',
    startAt: '2025.12',
    references: GlyphTree([
      LinkItem(
        icon: ProjectIcon.github,
        label: 'Github',
        url: 'https://github.com/DDRRDDDD/DDRRDDDD.github.io',
      ),
    ]),
  )
  ;

  final ProjectIcon primaryIcon;
  final ProjectType type;
  final String? title;
  final String subTitle;
  final String? description;
  final GlyphBuffer<String> labels;
  final String? bannerAssetPath;
  final String role;
  final String startAt;
  final String? endAt;
  final double? myContribution;
  final GlyphBuffer<String>? teamSummaries;
  final GlyphTree<LinkItem>? references;

  const Project({
    required this.primaryIcon,
    required this.type,
    this.title,
    required this.subTitle,
    this.description,
    required this.labels,
    this.bannerAssetPath,
    required this.role,
    required this.startAt,
    this.endAt,
    this.myContribution,
    this.teamSummaries,
    this.references,
  });

  factory Project.fromPath(String rawPath) {
    final String camelCasePath = rawPath.camelCase;
    return Project.values.byName(camelCasePath);
  }

  @override
  String get glyphs {
    final StringBuffer buffer = StringBuffer()
      ..write(type.glyphs)
      ..write(period)
      ..write(teamDetail)
      ..write(title ?? '')
      ..write(subTitle)
      ..write(description ?? '')
      ..write(role)
      ..write(labels.glyphs)
      ..write(teamSummaries?.glyphs ?? '')
      ..write(references?.glyphs ?? '');

    return buffer.toString();
  }

  String get period {
    return '$startAt ~ ${endAt ?? '진행 중'}';
  }

  String? get teamDetail {
    final StringBuffer buffer = StringBuffer();

    if (teamSummaries != null && teamSummaries!.isNotEmpty) {
      final int count = teamSummaries!.length;
      final String team = teamSummaries!.join(', ');

      buffer.write('총 $count명 ($team)');
    }

    if (buffer.isNotEmpty) {
      buffer.write(' - ');
    }

    if (myContribution != null) {
      final int percent = (myContribution! * 100).toInt();
      buffer.write('기여도 $percent%');
    }

    return buffer.isNotEmpty ? buffer.toString() : null;
  }
}

class LinkItem with GlyphLabelMixin {
  final ProjectIcon icon;
  @override
  final String label;
  final String url;

  const LinkItem({
    required this.icon,
    required this.label,
    required this.url,
  });
}
