import 'package:flutter/material.dart';

const Radius defaultRadius = Radius.circular(24);

class BentoContainer extends StatelessWidget {
  static const double bentoWidth = 240;
  static const double bentoHeight = 220;
  static const double bentoGap = 20;
  static const EdgeInsets contentPadding = EdgeInsets.all(24);
  static const BorderRadius borderRadius = BorderRadius.all(defaultRadius);

  const BentoContainer({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.color = Colors.transparent,
    this.border,
    required this.child,
  });

  final double width;
  final double height;
  final Color color;
  final Border? border;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: contentPadding,
        child: child,
      ),
    );
  }
}
