import 'package:flutter/material.dart';
import 'package:font_kit/font_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:recase/recase.dart';

import '../extension/common_extension.dart';
import '../extension/route_extension.dart';
import '../view/bento_grid_container.dart';
import '../view/bento_grid_scaffold.dart';
import '../view/main_grid.dart';
import '../view/project_grid.dart';
import '../widget/checkmark_splash.dart';
import '../widget/contact_form.dart';
import '../widget/project_sheet.dart';
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
                  pageBuilder: (_, state) => FlowDialogPage(
                    key: state.pageKey,
                    children: [
                      ContactForm(),
                      CheckmarkSplash(),
                    ]
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
                  path: ':projectName',
                  parentNavigatorKey: rootNavigatorKey,
                  pageBuilder: (_, state) => SlideSheetPage(
                    key: state.pageKey,
                    child: ProjectSheet(
                      stepIndex: state.queryInt('step'),
                      project: state
                          .requirePathString('projectName')
                          .let(ReCase.new).camelCase
                          .let(Project.values.byName),
                    ),
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
