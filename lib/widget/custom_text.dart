import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';
import '../theme/font_theme.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.color,
    required this.fontStyle,
    required this.text,
  }) : textSpan = null;

  const CustomText.rich({
    super.key,
    this.color,
    required this.fontStyle,
    required this.textSpan,
  }) : text = null;

  final Color? color;
  final FontTheme fontStyle;
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

class CustomHoverText extends StatefulWidget {
  const CustomHoverText({
    super.key,
    required this.text,
    required this.fontStyle,
    this.color,
    this.hoverColor,
    this.duration = const Duration(milliseconds: 100),
  });

  final String text;
  final FontTheme fontStyle;
  final Color? color;
  final Color? hoverColor;
  final Duration duration;

  @override
  State<CustomHoverText> createState() => _CustomHoverTextState();
}

class _CustomHoverTextState extends State<CustomHoverText> {
  late bool _isHovered;

  @override
  void initState() {
    super.initState();
    _isHovered = false;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedDefaultTextStyle(
        style: TextStyle(
          color: _isHovered
              ? widget.hoverColor ?? context.colorTheme.textSub
              : widget.color ?? context.colorTheme.textMain,
          fontFamily: widget.fontStyle.fontFamily,
          fontSize: widget.fontStyle.fontSize,
          height: widget.fontStyle.height,
          letterSpacing: widget.fontStyle.letterSpacing,
          fontVariations: widget.fontStyle.fontVariations,
        ),
        duration: widget.duration,
        child: Text(widget.text),
      ),
    );
  }
}
