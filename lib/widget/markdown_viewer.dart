import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:path/path.dart';

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
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.hasData) {
          return MarkdownBody(
            data: snapshot.data!,
            styleSheet: MarkdownStyleSheet(
              h1: const TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              h2: const TextStyle(color: Colors.blue, fontSize: 30),
              blockquoteDecoration: const BoxDecoration(color: Colors.grey),
            ),
          );
        }

        return const SizedBox.shrink();
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
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget get content {
    return MarkdownViewer(assetPath: assetPath);
  }
}
