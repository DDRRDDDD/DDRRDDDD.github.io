import 'package:flutter/material.dart';
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
        items: const [
          NavigationItem(
            size: 24,
            icon: Icons.person_outline,
            label: 'ABOUT ME',
          ),
          NavigationItem(
            size: 20,
            icon: Icons.rocket_launch_outlined,
            label: 'PROJECTS',
          ),
        ],
      ),
      floatingActionButtonLocation: const NavigationBarLocation(),
    );
  }
}
