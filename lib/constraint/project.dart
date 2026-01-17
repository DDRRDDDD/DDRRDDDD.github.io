import 'package:flutter/material.dart';

enum Project {
  oneHour(
    primaryIcon: Icons.smartphone,
    type: ProjectType.main,
    title: '원아워',
    subTitle: '이웃과 소소한 모임부터 대화까지',
    description: '시간 남을 때 근처 사람과 가볍게 만날 수 있는 번개 모임 및 이웃 연결 대화 서비스입니다.',
    labels: ['Flutter', 'Firebase', 'Riverpod'],
    bannerAssetPath: 'assets/image/one-hour.jpg',
  ),
  myTurn(
    primaryIcon: Icons.flag,
    type: ProjectType.main,
    title: '마이턴',
    subTitle: '보드게임 모임 플랫폼',
    description: '\'원아워\'의 피벗 프로젝트,\n모임의 규모를 보드게임으로 집중한 애플리케이션',
    labels: ['Flutter', 'Supabase', 'Riverpod', 'GoRouter'],
    bannerAssetPath: 'assets/image/my-turn.jpg',
  ),
  myPortfolio(
    primaryIcon: Icons.code,
    type: ProjectType.sub,
    subTitle: '플러터 포트폴리오 웹사이트',
    labels: ['Flutter', 'GoRouter', 'Forge2D', 'Rive'],
  );

  final IconData primaryIcon;
  final ProjectType type;
  final String? title;
  final String subTitle;
  final String? description;
  final List<String> labels;
  final String? bannerAssetPath;

  const Project({
    required this.primaryIcon,
    required this.type,
    this.title,
    required this.subTitle,
    this.description,
    required this.labels,
    this.bannerAssetPath,
  });
}

enum ProjectType {
  main('Main Project'),
  sub('Sub Project')
  ;

  final String label;

  const ProjectType(this.label);
}
