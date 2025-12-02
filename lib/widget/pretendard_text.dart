import 'package:flutter/material.dart';

import '../token/app_typography.dart';

class PretendardText extends StatelessWidget {
  const PretendardText({
    super.key,
    this.typography,
    this.color,
    required this.text,
  }) : textSpan = null;

  const PretendardText.rich({
    super.key,
    this.typography,
    this.color,
    required this.textSpan,
  }) : text = null;

  final AppTypography? typography;
  final Color? color;
  final String? text;
  final TextSpan? textSpan;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: typography?.style(color: color),
        children: [?textSpan],
      ),
    );
  }
}
