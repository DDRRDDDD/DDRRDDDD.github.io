import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:path/path.dart';

import '../extension/theme_extension.dart';
import '../theme/markdown_theme.dart';
import 'milestone_list.dart';

class MarkdownViewer extends StatelessWidget {
  const MarkdownViewer({
    super.key,
    required this.assetPath,
  });

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString(assetPath),
      builder: (context, snapshot) => switch (snapshot) {
        AsyncSnapshot(hasData: false) => const SizedBox.shrink(),
        _ => MarkdownBody(
          fitContent: false,
          data: snapshot.requireData,
          styleSheet: MarkdownTheme.styleSheet,
        ),
      },
    );
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
          fontWeight: FontWeight.w700,
          color: context.colorTheme.textMain,
          shadows: [
            Shadow(
              offset: Offset(0, 1),
              blurRadius: 2.0,
              color: context.colorTheme.textSub.withValues(
                alpha: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget get content {
    return MarkdownViewer(assetPath: assetPath);
  }
}
