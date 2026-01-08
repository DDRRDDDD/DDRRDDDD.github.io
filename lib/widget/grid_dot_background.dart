import 'package:flutter/material.dart';

import '../extension/brightness_extension.dart';
import '../extension/theme_extension.dart';
import '../theme/color_theme.dart';
import 'theme_mode_provider.dart';

class GridDotContainer extends StatelessWidget {
  const GridDotContainer({
    super.key,
    this.dotSpacing = 40.0,
    required this.dotColor,
    required this.child,
  });

  factory GridDotContainer.background(BuildContext context, Widget? child) {
    return GridDotContainer(
      dotColor: ColorThemeExtension.defaultPrimary.withValues(
        alpha: BrightnessProvider.of(context).value.isLight ? 0.25 : 0.4,
      ),
      child: child!,
    );
  }

  final double dotSpacing;
  final Color dotColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorTheme.background,
      child: CustomPaint(
        painter: _GridPatternPainter(
          color: dotColor,
          spacing: dotSpacing,
        ),
        child: child,
      ),
    );
  }
}

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

    final double startX = (size.width % spacing) / 2;
    final double startY = (size.height % spacing) / 2;

    for (double x = startX; x <= size.width; x += spacing) {
      for (double y = startY; y <= size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_GridPatternPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.spacing != spacing;
  }
}
