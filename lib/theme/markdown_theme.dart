import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:markdown/markdown.dart' as md;

import '../extension/common_extension.dart';
import '../extension/markdown_extension.dart';
import '../extension/theme_extension.dart';
import 'color_theme.dart';
import 'text_theme.dart';

class MarkdownTheme {
  const MarkdownTheme._();

  static const double spacing = 16;

  static MarkdownStyleSheet styleSheet(BuildContext context) {
    final ColorThemeExtension colorTheme = context.colorTheme;
    final TextThemeExtension textTheme = context.textTheme;

    return MarkdownStyleSheet(
      p: textTheme.bodyRegular.copyWith(
        color: colorTheme.textMain,
      ),
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
      em: textTheme.bodyRegular.copyWith(
        color: colorTheme.primary,
        fontVariations: const [
          FontVariation.weight(500),
          FontVariation.italic(0.3),
        ],
      ),

      blockquote: textTheme.bodyRegular.copyWith(
        color: colorTheme.textSub,
        height: 1.6,
      ),
      blockquoteDecoration: BoxDecoration(
        color: colorTheme.surfaceAlt.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          left: BorderSide(
            color: colorTheme.secondary,
            width: 4.0,
          ),
        ),
      ),
      blockquotePadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),

      code: textTheme.bodyRegular.copyWith(
        fontFamily: 'JetBrainsMono',
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
      listBullet: textTheme.bodyRegular.copyWith(
        color: colorTheme.textSub,
      ),

      a: textTheme.bodyRegular.copyWith(
        color: colorTheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: colorTheme.primary.withValues(alpha: 0.5),
      ),

      blockSpacing: spacing,
    );
  }

  static MarkdownBuilders markdownBuilders() {
    return MarkdownBuilders(
      strong: StrongTextBuilder(),
      code: CodeTextBuilder(),
    );
  }
}

class StrongTextBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfterWithContext(
    BuildContext context,
    md.Element element,
    TextStyle? preferredStyle,
    TextStyle? parentStyle,
  ) {
    return Text.rich(
      TextSpan(
        text: element.textContent,
        style: parentStyle?.copyWith(
          fontVariations: const [FontVariation.weight(700)],
        ),
      ),
    );
  }
}

class CodeTextBuilder extends MarkdownElementBuilder {
  CodeTextBuilder();

  @override
  Widget? visitElementAfterWithContext(
    BuildContext context,
    md.Element element,
    TextStyle? preferredStyle,
    TextStyle? parentStyle,
  ) {
    if (element.isCodeBlock) {
      return null;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorTheme.outline,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
        ),
        child: Text(
          element.textContent,
          style: preferredStyle,
        ),
      ),
    );
  }
}

class MarkdownBuilders extends DelegatingMap<String, MarkdownElementBuilder>
    with UnmodifiableMapMixin<String, MarkdownElementBuilder> {
  const MarkdownBuilders._(super.base);

  factory MarkdownBuilders({
    MarkdownElementBuilder? strong,
    MarkdownElementBuilder? code,
  }) {
    return MarkdownBuilders._({
      'strong': ?strong,
      'code': ?code,
    });
  }
}
