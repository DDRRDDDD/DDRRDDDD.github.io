import 'package:flutter/material.dart';

class GridDotContainer extends StatelessWidget {
  const GridDotContainer({
    super.key,
    this.padding,
    this.dotSpacing = 40.0,
    required this.dotColor,
    required this.child,
  });

  final EdgeInsetsGeometry? padding;
  final double dotSpacing;
  final Color dotColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GridPatternPainter(
        color: dotColor,
        spacing: dotSpacing,
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}

/// 실제 패턴을 그리는 Painter 클래스
class _GridPatternPainter extends CustomPainter {
  final Color color;
  final double spacing;

  _GridPatternPainter({
    required this.color,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    const double radius = 1.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_GridPatternPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.spacing != spacing;
  }
}
