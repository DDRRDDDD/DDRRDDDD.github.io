import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/bento_grid_container.dart';
import '../view/bento_grid_scaffold.dart';
import '../view/main_grid.dart';
import '../view/project_grid.dart';
import '../widget/contact_form_dialog.dart';
import '../widget/markdown_viewer.dart';
import '../widget/project_sheet.dart';
import '../widget/vertical_stepper.dart';
import 'dialog_page.dart';
import 'side_sheet_page.dart';

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
                  pageBuilder: (_, state) => DialogPage(
                    key: state.pageKey,
                    child: ContactFormDialog(),
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
              routes: [
                GoRoute(
                  path: 'one-hour',
                  parentNavigatorKey: rootNavigatorKey,
                  pageBuilder: (_, state) => SlideSheetPage(
                    key: state.pageKey,
                    child: const ProjectSheet(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

