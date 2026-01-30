import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:highlight/highlight.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import '../extension/common_extension.dart';
import '../extension/image_extension.dart';
import '../extension/theme_extension.dart';
import '../theme/markdown_theme.dart';
import 'milestone_list.dart';

class MarkdownViewer extends StatelessWidget {
  const MarkdownViewer({
    super.key,
    required this.assetPath,
  });

  final String assetPath;

  void _onTapLink(_, String? href, _) {
    href?.let(Uri.parse).let(launchUrl);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString(assetPath),
      builder: _buildWidget,
    );
  }

  Widget _buildWidget(BuildContext context, AsyncSnapshot<String> snapshot) {
    if (!snapshot.hasData) {
      return const SizedBox.shrink();
    }

    final MarkdownStyleSheet styleSheet = MarkdownTheme.styleSheet(context);
    final MarkdownBuilders builders = MarkdownTheme.markdownBuilders();

    return MarkdownBody(
      onTapLink: _onTapLink,
      imageBuilder: _MarkdownAssetImage.builder,
      fitContent: false,
      softLineBreak: true,
      data: snapshot.requireData,
      styleSheet: styleSheet,
      builders: builders,
      syntaxHighlighter: CodeSyntaxHighlighter(
        textStyle: styleSheet.code!,
        syntaxTheme: context.codeSyntaxTheme,
      ),
    );
  }
}

class _MarkdownAssetImage extends StatelessWidget {
  const _MarkdownAssetImage({
    super.key,
    required this.uri,
  });

  factory _MarkdownAssetImage.builder(Uri uri, _, _) {
    return _MarkdownAssetImage(uri: uri);
  }

  final Uri uri;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MarkdownTheme.spacing,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Image.asset(
          uri.toString(),
          fit: BoxFit.contain,
          cacheWidth: constraints.maxWidth.cacheSize(context),
        ),
      ),
    );
  }
}

class CodeSyntaxHighlighter extends SyntaxHighlighter {
  final TextStyle textStyle;
  final Map<String, TextStyle> syntaxTheme;

  CodeSyntaxHighlighter({
    required this.textStyle,
    required this.syntaxTheme,
  });

  @override
  TextSpan format(String source) {
    final Result result = highlight.parse(source, autoDetection: true);

    return TextSpan(
      style: textStyle,
      children: result.nodes?.map(_buildSpan).toList(),
    );
  }

  // 단일 Node를 TextSpan으로 변환 재귀 함수
  TextSpan _buildSpan(Node node) {
    // 텍스트 노드인 경우 (Leaf Node)
    if (node.value != null) {
      return TextSpan(
        style: node.className?.let(syntaxTheme.lookup),
        text: node.value,
      );
    }

    // 자식 노드가 있는 경우 (Branch Node)
    if (node.children != null) {
      return TextSpan(
        style: node.className?.let(syntaxTheme.lookup),
        children: node.children!.map(_buildSpan).toList(),
      );
    }

    // 예외 케이스 (빈 노드)
    return const TextSpan();
  }
}

class MilestoneMarkdown extends Milestone {
  final String assetPath;

  const MilestoneMarkdown(this.assetPath);

  @override
  Widget get title {
    return Builder(
      builder: (context) => Text(
        basenameWithoutExtension(assetPath),
        maxLines: 2,
        softWrap: true,
        style: context.textTheme.heroBadge.copyWith(
          color: context.colorTheme.textMain,
        ),
      ),
    );
  }

  @override
  Widget get content {
    return MarkdownViewer(assetPath: assetPath);
  }
}
