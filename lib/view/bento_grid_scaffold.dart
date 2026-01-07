import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../extension/brightness_extension.dart';
import '../extension/theme_extension.dart';
import '../widget/grid_dot_background.dart';
import '../widget/navigation_bar.dart';
import '../widget/theme_mode_provider.dart';

class BentoGridScaffold extends StatelessWidget {
  const BentoGridScaffold({
    super.key,
    required this.navigationShell,
  });

  factory BentoGridScaffold.shell(_, _, StatefulNavigationShell shell) {
    return BentoGridScaffold(navigationShell: shell);
  }

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: const NavigationBarLocation(),
      floatingActionButton: const FloatingNavigationBar(),
      body: GridDotContainer(
        dotColor: context.colorTheme.primary.withValues(
          alpha: BrightnessProvider.of(context).value.isLight ? 0.25 : 0.4,
        ),
        child: navigationShell,
      ),
    );
  }
}
