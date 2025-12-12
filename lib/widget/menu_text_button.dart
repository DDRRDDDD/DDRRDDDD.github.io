import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../extension/theme_extension.dart';

class MenuTextButton extends StatelessWidget {
  const MenuTextButton({
    super.key,
    this.onTap,
    this.textStyle,
    required this.text,
  });

  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final String text;

  WidgetPropertyResolver<Color> _resolveTextColor(BuildContext context) {
    return (states) => states.contains(WidgetState.hovered)
        ? context.colorTheme.primary
        : context.colorTheme.textMain;
  }

  WidgetPropertyResolver<TextStyle> _resolveTextStyle(BuildContext context) {
    if (textStyle != null) {
      return (states) => textStyle!;
    }

    return (states) => GoogleFonts.notoSansKr(
      textStyle: context.textTheme.buttonText,
      color: context.colorTheme.textMain,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: WidgetStateColor.transparent,
        foregroundColor: WidgetStateColor.resolveWith(
          _resolveTextColor(context),
        ),
        textStyle: WidgetStateTextStyle.resolveWith(
          _resolveTextStyle(context),
        ),
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }
}
