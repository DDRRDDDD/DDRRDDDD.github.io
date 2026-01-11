import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/bento_grid_container.dart';
import '../view/bento_grid_scaffold.dart';
import '../view/main_grid.dart';
import '../view/project_grid.dart';
import '../widget/input_dialog.dart';
import 'dialog_route.dart';

typedef NavigationKey = GlobalKey<NavigatorState>;
final NavigationKey rootNavigatorKey = NavigationKey(debugLabel: 'root');

final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  routes: [
    StatefulShellRoute(
      navigatorContainerBuilder: BentoGridContainer.shell,
      builder: BentoGridScaffold.shell,
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (_, _) => const MainGrid(),
              routes: [
                GoRoute(
                  path: 'input',
                  parentNavigatorKey: rootNavigatorKey,
                  pageBuilder: (_, _) => DialogPage(
                    child: InputDialog(),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/project',
              builder: (_, _) => const ProjectGrid(),
            ),
          ],
        ),
      ],
    ),
  ],
);
