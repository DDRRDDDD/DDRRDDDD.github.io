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
          builder: (_, _) => const AboutMeSection(),
        ),
        SectionBranch(
          path: '/skills',
          builder: (_, _) => const SkillsSection(),
        ),
        SectionBranch(
          path: '/project',
          builder: (_, _) => const ProjectSection(),
        ),
        SectionBranch(
          path: '/contact',
          builder: (_, _) => const ContactSection(),
        ),
      ],
    ),
  ],
);

Widget _portfolioContainerBuilder(
  BuildContext context,
    StatefulNavigationShell shell,
  List<Widget> children,
) {
  return const HeroSection();
}

Widget _portfolioBuilder(
  BuildContext context,
  GoRouterState state,
  StatefulNavigationShell shell,
) {
  return MyPortfolioScaffold(child: shell);
}
