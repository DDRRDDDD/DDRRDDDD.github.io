import 'package:flutter/material.dart';

class PretendardText extends StatelessWidget {
  const PretendardText({
    super.key,
    this.color,
    required this.typography,
    required this.text,
  }) : textSpan = null;

  const PretendardText.rich({
    super.key,
    this.color,
    required this.typography,
    required this.textSpan,
  }) : text = null;

  final Typography typography;
  final Color? color;
  final String? text;
  final TextSpan? textSpan;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: typography.textStyle(color: color),
        children: [?textSpan],
      ),
    );
  }
}

enum Typography {
  headline1(
    fontWeight: bold,
    fontSize: 24,
    lineHeight: 29,
  );

  static const String fontFamily = 'Pretendard';
  static const double letterSpacing = -0.25;

  static const FontVariation medium = FontVariation.weight(500);
  static const FontVariation semiBold = FontVariation.weight(600);
  static const FontVariation bold = FontVariation.weight(700);

  final FontVariation fontWeight;
  final double fontSize;
  final double lineHeight;

  const Typography({
    required this.fontWeight,
    required this.fontSize,
    required this.lineHeight,
  });

  TextStyle textStyle({Color? color}) {
    return TextStyle(
      color: color,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      fontVariations: [fontWeight],
      fontSize: fontSize,
      height: lineHeight / fontSize,
    );
  }
}