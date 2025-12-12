import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';
import 'developer_bragging.dart';
import 'menu_text_button.dart';

class MainAppBarDelegate extends SliverPersistentHeaderDelegate {
  const MainAppBarDelegate({
    required this.labels,
    this.onMenuTap,
  });

  final List<String> labels;
  final ValueChanged<int>? onMenuTap;

  @override
  double get maxExtent {
    return 80.0;
  }

  @override
  double get minExtent {
    return 0.0;
  }

  @override
  bool shouldRebuild(MainAppBarDelegate oldDelegate) {
    return oldDelegate.onMenuTap != onMenuTap;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, _) {
    return Container(
      alignment: .center,
      decoration: BoxDecoration(
        color: context.colorTheme.background,
        border: Border(
          bottom: BorderSide(
            color: context.colorTheme.outline,
          ),
        ),
      ),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Row(
          children: [
            DeveloperBragging(
              onTap: () => onMenuTap?.call(0),
              enabled: shrinkOffset < maxExtent,
            ),
            const Spacer(),
            ...List.generate(
              labels.length,
              (index) => MenuTextButton(
                onTap: () => onMenuTap?.call(index + 1),
                text: labels.elementAt(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
