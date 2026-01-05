import 'package:flutter/material.dart';

class BentoContainer extends StatelessWidget {
  static const double bentoWidth = 240;
  static const double bentoHeight = 220;
  static const double bentoGap = 20;
  static const EdgeInsets contentPadding = EdgeInsets.all(24);
  static const BorderRadius borderRadius = BorderRadius.all(
    Radius.circular(24),
  );

  const BentoContainer({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.color = Colors.transparent,
    required this.child,
  });

  final double width;
  final double height;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: child,
        ),
      ),
    );
  }
}
