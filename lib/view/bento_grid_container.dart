import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BentoGridContainer extends StatelessWidget {
  const BentoGridContainer({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  factory BentoGridContainer.shell(
    _,
    StatefulNavigationShell shell,
    List<Widget> children,
  ) {
    return BentoGridContainer(
      currentIndex: shell.currentIndex,
      children: children,
    );
  }

  final int currentIndex;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      layoutBuilder: _buildLayout,
      transitionBuilder: _buildTransition,
      child: children.elementAt(currentIndex),
    );
  }

  Widget _buildLayout(List<Widget> entries) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: entries,
    );
  }

  Widget _buildTransition(
    Widget child,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return FadeThroughTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      fillColor: Colors.transparent,
      child: child,
    );
  }
}
