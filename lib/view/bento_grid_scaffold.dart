import 'package:flutter/material.dart';
import 'package:font_kit/font_kit.dart';
import 'package:go_router/go_router.dart';

import '../widget/navigation_bar.dart';

class BentoGridScaffold extends StatelessWidget {
  static const double verticalPadding = 50;

  const BentoGridScaffold({
    super.key,
    required this.shell,
  });

  factory BentoGridScaffold.shell(_, _, StatefulNavigationShell shell) {
    return BentoGridScaffold(shell: shell);
  }

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: shell,
      floatingActionButton: FloatingNavigationBar(
        onNavigate: shell.goBranch,
        currentIndex: shell.currentIndex,
        items: [
          NavigationItem(
            size: 24,
            icon: Icons.person_outline,
            label: Constraints.aboutMe.label,
          ),
          NavigationItem(
            size: 20,
            icon: Icons.rocket_launch_outlined,
            label: Constraints.projects.label,
          ),
        ],
      ),
      floatingActionButtonLocation: const NavigationBarLocation(),
    );
  }
}
