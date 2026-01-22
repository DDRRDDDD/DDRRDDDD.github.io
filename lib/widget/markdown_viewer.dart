import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'milestone_list.dart';

const String markdownData = '''
# ExpansionTile Demo

일반적인 텍스트입니다. 아래 리스트를 눌러보세요.
```javascript
let sumNumbers = (firstNum, lastNum) => {
  return firstNum + lastNum;
};
sumNumbers(100, 200);
```　

::: 두 번째 요약
여기에는 간단한 내용만 들어갑니다.
:::

마지막 텍스트입니다.
''';

class MarkdownViewer extends StatelessWidget {
  const MarkdownViewer({
    super.key,
    this.assetPath,
  });

  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: markdownData,
      styleSheet: MarkdownStyleSheet(
        h1: TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        h2: TextStyle(color: Colors.blue, fontSize: 30),
        blockquoteDecoration: BoxDecoration(color: Colors.grey),
      ),
    );
  }
}

class MilestoneMarkdown extends Milestone {
  final String assetPath;

  const MilestoneMarkdown(this.assetPath);

  @override
  Widget get title {
    return Builder(
      builder: (context) => Text(assetPath),
    );
  }

  @override
  Widget get content {
    return MarkdownViewer(assetPath: assetPath);
  }
}
