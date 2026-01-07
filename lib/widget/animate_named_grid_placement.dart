import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class AnimateNamedGridPlacement extends StatelessWidget {
  const AnimateNamedGridPlacement({
    super.key,
    this.order = 1,
    required this.areaName,
    required this.child,
  });

  final int order;
  final String areaName;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NamedAreaGridPlacement(
      areaName: areaName,
      child: AnimatePlacement(
        order: order,
        child: child,
      ),
    );
  }
}

class AnimatePlacement extends StatelessWidget {
  const AnimatePlacement({
    super.key,
    this.order = 1,
    required this.child,
  });

  final int order;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final int clampedOrder = order < 0 ? 0 : order;

    return Animate(
      effects: [
        FadeEffect(
          duration: 500.ms,
          delay: (clampedOrder * 100).ms,
        ),
        SlideEffect(
          begin: const Offset(0, 0.025),
          end: Offset.zero,
          duration: 500.ms,
          delay: (clampedOrder * 100).ms,
        ),
      ],
      child: child,
    );
  }
}
