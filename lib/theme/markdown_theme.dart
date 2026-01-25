import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import '../extension/theme_extension.dart';

/// 가변 폰트로 전환 (noto sans, jetbrain)
/// 테마 모듈화 전략 구상
/// 마크다운 스타일 시트 확정
class MarkdownTheme {
  const MarkdownTheme._();

  static const Color _fgDefault = Color(0xFF24292f);
  static const Color _fgMuted = Color(0xFF57606a);
  static const Color _accentFg = Color(0xFF0969da);
  static const Color _canvasSubtle = Color(0xFFf6f8fa);
  static const Color _borderDefault = Color(0xFFd0d7de);

  static MarkdownStyleSheet get styleSheet {
    const double baseFontSize = 16.0;
    const double codeFontSize = 13.6;

    return MarkdownStyleSheet(
      blockSpacing: baseFontSize,
      p: const TextStyle(
        fontSize: baseFontSize,
        color: _fgDefault,
        height: 1.5,
      ),
      a: const TextStyle(
        color: _accentFg,
        decoration: TextDecoration.none,
        fontVariations: [FontVariation.weight(600)],
      ),

      h1: const TextStyle(
        fontSize: 32.0,
        fontVariations: [FontVariation.weight(600)],
        color: _fgDefault,
        height: 1.25,
        letterSpacing: -0.5,
      ),
      h1Padding: const EdgeInsets.only(
        bottom: baseFontSize / 2,
      ),

      h2: const TextStyle(
        fontSize: 24.0,
        fontVariations: [FontVariation.weight(600)],
        color: _fgDefault,
        height: 1.25,
        letterSpacing: -0.3,
      ),
      h2Padding: const EdgeInsets.only(
        bottom: baseFontSize / 2,
      ),

      h3: const TextStyle(
        fontSize: 20.0,
        fontVariations: [FontVariation.weight(600)],
        color: _fgDefault,
        height: 1.25,
      ),

      h4: const TextStyle(
        fontSize: 16.0,
        fontVariations: [FontVariation.weight(600)],
        color: _fgDefault,
        height: 1.25,
      ),

      h5: const TextStyle(
        fontSize: 14.0,
        fontVariations: [FontVariation.weight(600)],
        color: _fgDefault,
        height: 1.25,
      ),

      h6: const TextStyle(
        fontSize: 13.6,
        fontVariations: [FontVariation.weight(600)],
        color: _fgMuted,
        height: 1.25,
      ),

      strong: const TextStyle(
        fontVariations: [FontVariation.weight(600)],
        color: _fgDefault,
      ),
      em: const TextStyle(
        fontStyle: FontStyle.italic,
        color: _fgDefault,
      ),

      blockquote: const TextStyle(
        fontSize: baseFontSize,
        color: _fgMuted,
      ),
      blockquoteDecoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: _borderDefault,
            width: 4.0,
          ),
        ),
      ),
      blockquotePadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),

      code: const TextStyle(
        fontFamily: 'JetBrainsMono',
        fontSize: codeFontSize,
        color: _fgDefault,
        height: 1.4,
      ),

      codeblockPadding: const EdgeInsets.all(16.0),
      codeblockDecoration: BoxDecoration(
        color: _canvasSubtle,
        borderRadius: BorderRadius.circular(6.0),
      ),

      listBullet: const TextStyle(
        color: _fgDefault,
        fontSize: baseFontSize,
      ),
      listIndent: 14.0,

      tableHead: const TextStyle(
        fontVariations: [FontVariation.weight(600)],
        color: _fgDefault,
      ),
      tableBody: const TextStyle(
        color: _fgDefault,
      ),
      tableBorder: TableBorder.all(
        color: _borderDefault,
        width: 1.0,
      ),
      tablePadding: const EdgeInsets.all(8.0),

      horizontalRuleDecoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: _borderDefault,
            width: 1.5,
          ),
        ),
      ),
    );
  }

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
        fontVariations: [FontVariation.weight(700)],
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
        fontVariations: [FontVariation.weight(400)],
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
        fontVariations: [FontVariation.weight(700)],
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
