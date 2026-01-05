import 'package:go_router/go_router.dart';

import '../extension/brightness_extension.dart';
import '../extension/theme_extension.dart';
import '../view/main_grid.dart';
import '../widget/grid_dot_background.dart';
import '../widget/theme_mode_provider.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, _, child) => GridDotContainer(
        dotColor: context.colorTheme.primary.withValues(
          alpha: BrightnessProvider.of(context).value.isLight ? 0.25 : 0.4,
        ),
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const MainGrid(),
        ),
      ],
    ),
  ],
);
