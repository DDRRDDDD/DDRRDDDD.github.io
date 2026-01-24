import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../extension/theme_extension.dart';

class MarkdownTheme {
  const MarkdownTheme._();

  static MarkdownStyleSheet create(BuildContext context) {
    return MarkdownStyleSheet(
      img: context.textTheme.sectionDescription.copyWith(
        color: context.colorTheme.textMain,
      ),
      p: context.textTheme.sectionDescription.copyWith(
        color: context.colorTheme.textMain,
      ),
      a: context.textTheme.sectionDescription.copyWith(
        color: context.colorTheme.primary,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.bold,
      ),
      h1: context.textTheme.sectionTitle.copyWith(
        color: context.colorTheme.textMain,
        height: 1.5,
      ),
      h2: context.textTheme.cardTitle.copyWith(
        fontSize: 24.0,
        color: context.colorTheme.textMain,
        height: 1.4,
      ),
      h3: context.textTheme.cardTitle.copyWith(
        color: context.colorTheme.textMain,
        height: 1.4,
      ),
      h4: context.textTheme.timelineTitle.copyWith(
        color: context.colorTheme.textMain,
      ),
      blockquote: context.textTheme.sectionDescription.copyWith(
        color: context.colorTheme.textSub,
        fontStyle: FontStyle.italic,
      ),
      blockquoteDecoration: BoxDecoration(
        color: context.colorTheme.outline,
        border: Border(
          left: BorderSide(
            width: 4,
            color: context.colorTheme.primary,
          ),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
      ),
      blockquotePadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      code: TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: 14.0,
        color: context.colorTheme.textMain,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      codeblockPadding: const EdgeInsets.all(16),
      codeblockDecoration: BoxDecoration(
        color: context.colorTheme.outline,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colorTheme.outline,
        ),
      ),
      listBullet: TextStyle(
        color: context.colorTheme.primary,
        fontSize: 16.0,
      ),
      strong: context.textTheme.sectionDescription.copyWith(
        color: context.colorTheme.textMain,
        fontWeight: FontWeight.w700,
      ),
      em: context.textTheme.sectionDescription.copyWith(
        color: context.colorTheme.textMain,
        fontStyle: FontStyle.italic,
      ),
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.colorTheme.outline,
          ),
        ),
      ),
    );
  }
}
