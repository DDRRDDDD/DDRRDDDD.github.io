import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';
import '../theme/font_theme.dart';

class PretendardText extends StatelessWidget {
  const PretendardText({
    super.key,
    this.color,
    required this.fontStyle,
    required this.text,
  }) : textSpan = null;

  const PretendardText.rich({
    super.key,
    this.color,
    required this.fontStyle,
    required this.textSpan,
  }) : text = null;

  final Color? color;
  final Pretendard fontStyle;
  final String? text;
  final TextSpan? textSpan;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: TextStyle(
          color: color ?? context.colorTheme.textMain,
          fontFamily: fontStyle.fontFamily,
          fontSize: fontStyle.fontSize,
          height: fontStyle.height,
          letterSpacing: fontStyle.letterSpacing,
          fontVariations: fontStyle.fontVariations,
        ),
        children: [?textSpan],
      ),
    );
  }
}
