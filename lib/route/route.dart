import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/about_me_section.dart';
import '../view/hero_section.dart';
import '../view/my_portfolio.dart';
import '../view/project_section.dart';
import '../view/skills_section.dart';
import '../view/contact_section.dart';
import 'section_branch.dart';

typedef NavigatorKey = GlobalKey<NavigatorState>;

final NavigatorKey rootNavigatorKey = NavigatorKey(debugLabel: 'root');

final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  routes: [
    StatefulShellRoute(
      builder: _portfolioBuilder,
      navigatorContainerBuilder: _portfolioContainerBuilder,
      branches: [
        SectionBranch(
          path: '/',
          builder: (_, _) => const HeroSection(),
        ),
        SectionBranch(
          path: '/about-me',
          menuName: 'About',
          builder: (_, _) => const AboutMeSection(),
        ),
        SectionBranch(
          path: '/skills',
          menuName: 'Skills',
          builder: (_, _) => const SkillsSection(),
        ),
        SectionBranch(
          path: '/project',
          menuName: 'Project',
          builder: (_, _) => const ProjectSection(),
        ),
        SectionBranch(
          path: '/contact',
          menuName: 'Contact',
          builder: (_, _) => const ContactSection(),
        ),
      ],
    ),
  ],
);

Widget _portfolioContainerBuilder(
  BuildContext context,
  StatefulNavigationShell navigationShell,
  List<Widget> children,
) {
  return MyPortfolioSectionContainer(
    navigationShell: navigationShell,
    children: children,
  );
}

Widget _portfolioBuilder(
  BuildContext context,
  GoRouterState state,
  StatefulNavigationShell shell,
) {
  return MyPortfolioScaffold(child: shell);
}
