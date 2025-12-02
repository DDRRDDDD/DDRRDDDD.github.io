import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'view/introduction_section.dart';
import 'view/my_portfolio.dart';
import 'view/project_section.dart';
import 'view/skills_section.dart';
import 'view/sub_project_section.dart';

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
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => Container(), // TODO 변경
            ),
          ],
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
  return ListView(
    children: [
      const IntroductionSection(),
      const SkillsSection(),
      const ProjectSection(),
      const SubProjectSection(),
    ],
  );
}

Widget _portfolioBuilder(
  BuildContext context,
  GoRouterState state,
  StatefulNavigationShell shell,
) {
  return MyPortfolioScaffold(child: shell);
}
