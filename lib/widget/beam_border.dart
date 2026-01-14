import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';
import '../theme/color_theme.dart';
import 'bento_container.dart';

class BeamBentoContainer extends StatefulWidget {
  const BeamBentoContainer({super.key});

  @override
  State<BeamBentoContainer> createState() => _BeamBentoContainerState();
}

class _BeamBentoContainerState extends State<BeamBentoContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => DecoratedBox(
        position: .foreground,
        decoration: ShapeDecoration(
          shape: BeamBorder(
            progress: _controller.value,
            borderRadius: BentoContainer.borderRadius,
            side: BorderSide(
              color: context.colorTheme.outline,
              width: 1.5,
            ),
          ),
        ),
        child: child,
      ),
      child: ClipRRect(
        borderRadius: BentoContainer.borderRadius,
        child: SizedBox.expand(
          
        ),
      ),
    );
  }
}

class BeamBorder extends RoundedRectangleBorder {
  final double progress;
  final Color colorFrom;
  final Color colorTo;

  const BeamBorder({
    required this.progress,
    required super.side,
    super.borderRadius,
    this.colorFrom = ColorThemeExtension.indigoVivid,
    this.colorTo = ColorThemeExtension.electricMagenta,
  });

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style == BorderStyle.none || side.width <= 0.0) {
      return;
    }

    // 원본 로직 그대로 좌표 계산 (정확도 100%)
    final RRect borderRect = borderRadius.resolve(textDirection).toRRect(rect);
    final RRect inner = borderRect.deflate(side.strokeInset);
    final RRect outer = borderRect.inflate(side.strokeOutset);

    // Beam Gradient 생성
    final Gradient gradient = SweepGradient(
      colors: [Colors.transparent, colorTo, colorFrom, Colors.transparent],
      stops: const [0.0, 0.1, 0.25, 0.26],
      transform: GradientRotation(progress * 2 * math.pi),
    );

    // 배경(정적) 테두리 그리기
    final Paint staticPaint = Paint()..color = side.color;

    // 빔(동적) 테두리 그리기
    final Paint beamPaint = Paint()..shader = gradient.createShader(rect);

    canvas.drawDRRect(outer, inner, staticPaint);
    canvas.drawDRRect(outer, inner, beamPaint);
  }

  @override
  BeamBorder copyWith({
    BorderSide? side,
    double? progress,
    BorderRadiusGeometry? borderRadius,
    Color? colorFrom,
    Color? colorTo,
  }) {
    return BeamBorder(
      side: side ?? this.side,
      progress: progress ?? this.progress,
      borderRadius: borderRadius ?? this.borderRadius,
      colorFrom: colorFrom ?? this.colorFrom,
      colorTo: colorTo ?? this.colorTo,
    );
  }

  @override
  ShapeBorder scale(double t) {
    return BeamBorder(
      side: side.scale(t),
      progress: progress,
      borderRadius: borderRadius * t,
      colorFrom: colorFrom,
      colorTo: colorTo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is BeamBorder &&
        runtimeType == other.runtimeType &&
        other.side == side &&
        other.progress == progress &&
        other.borderRadius == borderRadius &&
        other.colorFrom == colorFrom &&
        other.colorTo == colorTo;
  }

  @override
  int get hashCode {
    return Object.hash(progress, colorFrom, colorTo) & super.hashCode;
  }
}
