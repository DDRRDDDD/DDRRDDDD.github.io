import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';
import '../theme/font_theme.dart';

class PretendardText extends StatelessWidget {
  const PretendardText({
    super.key,
    this.color,
    required this.fontTheme,
    required this.text,
  }) : textSpan = null;

  const PretendardText.rich({
    super.key,
    this.color,
    required this.fontTheme,
    required this.textSpan,
  }) : text = null;

  final Pretendard fontTheme;
  final Color? color;
  final String? text;
  final TextSpan? textSpan;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: TextStyle(
          color: color ?? context.colorTheme.textMain,
          fontFamily: fontTheme.fontFamily,
          fontSize: fontTheme.fontSize,
          height: fontTheme.height,
          letterSpacing: fontTheme.letterSpacing,
          fontVariations: fontTheme.fontVariations,
        ),
        children: [?textSpan],
      ),
    );
  }
}
