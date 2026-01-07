import 'package:go_router/go_router.dart';

import '../view/bento_grid_container.dart';
import '../view/bento_grid_scaffold.dart';
import '../view/main_grid.dart';
import '../view/project_grid.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
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
