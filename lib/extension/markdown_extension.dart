import 'package:markdown/markdown.dart' as md;

import 'common_extension.dart';

extension CodeBlockElement on md.Element {
  bool get isCodeBlock {
    return textContent.contains('\n') ||
        (attributes.lookup('class')?.startsWith('language-') ?? false);
  }
}