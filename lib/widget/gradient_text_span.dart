import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class GradientTextSpan extends TextSpan {
  const GradientTextSpan._({
    super.text,
    super.style,
    super.children,
    super.recognizer,
    super.mouseCursor,
    super.onEnter,
    super.onExit,
    super.semanticsLabel,
    super.semanticsIdentifier,
    super.locale,
    super.spellOut,
  });

  factory GradientTextSpan({
    required String text,
    required TextStyle style,
    required List<Color> colors,
    List<double>? colorStops,
  }) {
    final double textWidth = TextPainter.computeWidth(
      textDirection: TextDirection.ltr,
      text: TextSpan(text: text, style: style),
    );

    final Gradient gradient = LinearGradient(
      colors: colors,
      stops: colorStops,
    );

    final Rect rect = Offset.zero & Size.fromWidth(textWidth);
    final Paint paint = Paint()..shader = gradient.createShader(rect);

    return GradientTextSpan._(
      style: style.copyWith(foreground: paint),
      text: text,
    );
  }
}
