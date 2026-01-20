import 'package:flutter/material.dart';

enum Project {
  oneHour(
    primaryIcon: Icons.smartphone,
    type: ProjectType.main,
    title: '원아워',
    subTitle: '이웃과 소소한 모임부터 대화까지',
    description: '시간 남을 때 근처 사람과 가볍게 만날 수 있는 \n번개 모임 및 이웃 연결 대화 서비스',
    labels: ['Flutter', 'Firebase', 'Riverpod'],
    bannerAssetPath: 'assets/image/one-hour.jpg',
    role: '클라이언트 개발',
    startAt: '2024.12',
    endAt: '2025.02',
    myContribution: 0.3,
    teamSummaries: ['기획/Flutter', 'Flutter'],
  ),
  myTurn(
    primaryIcon: Icons.flag,
    type: ProjectType.main,
    title: '마이턴',
    subTitle: '보드게임 모임 플랫폼',
    description: '\'원아워\'의 피벗 프로젝트,\n모임의 규모를 보드게임으로 집중한 애플리케이션',
    labels: ['Flutter', 'Supabase', 'Riverpod', 'GoRouter'],
    bannerAssetPath: 'assets/image/my-turn.jpg',
    role: '앱 개발 리드',
    startAt: '2025.07',
    endAt: '2025.12',
    myContribution: 0.9,
    teamSummaries: ['디자이너', '기획', '개발'],
  ),
  myPortfolio(
    primaryIcon: Icons.code,
    type: ProjectType.sub,
    subTitle: '플러터 포트폴리오 웹사이트',
    labels: ['Flutter', 'GoRouter', 'Forge2D', 'Rive'],
    role: '1인 전담 개발 (기획·디자인·구현)',
    startAt: '2025.12',
  )
  ;

  final IconData primaryIcon;
  final ProjectType type;
  final String? title;
  final String subTitle;
  final String? description;
  final List<String> labels;
  final String? bannerAssetPath;
  final String role;
  final String startAt;
  final String? endAt;
  final double? myContribution;
  final List<String>? teamSummaries;

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
  });

  bool get hasTeamSummary {
    return myContribution != null ||
        teamSummaries != null && teamSummaries!.isNotEmpty;
  }

  bool get hasLink {
    return true;
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

enum ProjectType {
  main('Main Project'),
  sub('Sub Project')
  ;

  final String label;

  const ProjectType(this.label);
}
