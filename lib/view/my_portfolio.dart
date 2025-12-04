import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';
import '../widget/theme_toggle.dart';

class MyPortfolioScaffold extends StatelessWidget {
  const MyPortfolioScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.background,
      body: Align(
        alignment: Alignment.topCenter,
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: child,
        ),
      ),
      floatingActionButton: const BrightnessToggle(),
    );
  }
}
