import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../extension/route_extension.dart';
import '../extension/theme_extension.dart';
import '../route/section_branch.dart';
import 'developer_bragging.dart';
import 'menu_text_button.dart';

class MainAppBarDelegate extends SliverPersistentHeaderDelegate {
  const MainAppBarDelegate();

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
    return false;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, _) {
    final List<SectionBranch> menuBranches = context.menuSectionBranches;

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
              onTap: () => context.go('/'),
              enabled: shrinkOffset < maxExtent,
            ),
            const Spacer(),
            ...menuBranches.map(
              (branch) => MenuTextButton(
                onTap: () => context.go(branch.initialLocation ?? '/'),
                text: branch.menuName!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
