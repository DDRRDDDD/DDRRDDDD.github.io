import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../extension/theme_extension.dart';
import 'color_theme.dart';
import 'text_theme.dart';

class MarkdownTheme {
  const MarkdownTheme._();

  static MarkdownStyleSheet styleSheet(BuildContext context) {
    final ColorThemeExtension colorTheme = context.colorTheme;
    final TextThemeExtension textTheme = context.textTheme;

    final TextStyle baseTextStyle = textTheme.bodyRegular.copyWith(
      inherit: true,
      color: colorTheme.textMain,
    );

    return MarkdownStyleSheet(
      p: baseTextStyle,
      h1: textTheme.sectionTitle.copyWith(
        fontSize: 28.0,
        color: colorTheme.textMain,
        height: 1.3,
      ),
      h1Padding: const EdgeInsets.symmetric(
        vertical: 14.0,
      ),
      h2: textTheme.sectionTitle.copyWith(
        fontSize: 24.0,
        color: colorTheme.textMain,
        height: 1.35,
      ),
      h2Padding: const EdgeInsets.symmetric(
        vertical: 12.0,
      ),
      h3: textTheme.cardTitle.copyWith(
        fontSize: 21.0,
        color: colorTheme.textMain,
        height: 1.4,
      ),
      h3Padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      h4: textTheme.timelineTitle.copyWith(
        fontSize: 18.0,
        color: colorTheme.textMain,
        height: 1.4,
      ),
      h5: textTheme.buttonText.copyWith(
        fontSize: 16.0,
        color: colorTheme.textMain,
      ),
      h6: textTheme.labelMedium.copyWith(
        fontSize: 14.0,
        color: colorTheme.textSub,
        fontVariations: const [FontVariation.weight(700)],
      ),
      em: baseTextStyle.copyWith(
        color: colorTheme.primary,
        fontStyle: FontStyle.italic,
        fontVariations: const [FontVariation.weight(500)],
      ),

      blockquote: baseTextStyle.copyWith(
        color: colorTheme.textSub,
        height: 1.6,
      ),
      blockquoteDecoration: BoxDecoration(
        color: colorTheme.surfaceAlt.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          left: BorderSide(
            color: colorTheme.primary,
            width: 4.0,
          ),
        ),
      ),
      blockquotePadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),

      code: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: baseTextStyle.fontSize,
        color: colorTheme.textSub,
        fontWeight: FontWeight.w500,
      ),
      codeblockPadding: const EdgeInsets.all(16.0),
      codeblockDecoration: BoxDecoration(
        color: colorTheme.surfaceAlt,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colorTheme.outline),
      ),

      horizontalRuleDecoration: BoxDecoration(
        border: Border.all(
          color: colorTheme.outline,
          width: 0.5,
        ),
      ),

      listIndent: 12.0,
      listBullet: baseTextStyle.copyWith(
        color: colorTheme.textSub,
      ),

      a: baseTextStyle.copyWith(
        color: colorTheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: colorTheme.primary.withValues(alpha: 0.5),
      ),

      blockSpacing: 16.0,
    );
  }
}
