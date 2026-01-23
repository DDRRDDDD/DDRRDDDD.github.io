import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../extension/theme_extension.dart';
import 'project_sheet.dart';

class ProjectSheetHeader extends StatelessWidget {
  const ProjectSheetHeader({
    super.key,
    required this.icon,
    required this.subTitle,
    this.title,
  });

  final IconData icon;
  final String? title;
  final String subTitle;

  String get combinedTitle {
    return (title != null && title!.isNotEmpty)
        ? '$title - $subTitle'
        : subTitle;
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: context.colorTheme.surfaceAlt,
      surfaceTintColor: context.colorTheme.surfaceAlt,
      titleSpacing: ProjectSheet.contentSpacing,
      title: Align(
        alignment: .centerLeft,
        child: Text(
          combinedTitle,
          maxLines: 1,
          overflow: .ellipsis,
          style: context.textTheme.cardTitle.copyWith(
            color: context.colorTheme.textMain,
          ),
        ),
      ),
      actionsPadding: const EdgeInsetsDirectional.only(
        end: ProjectSheet.contentSpacing,
      ),
      actions: [
        InkWell(
          onTap: context.pop,
          customBorder: const CircleBorder(),
          child: Icon(
            Icons.keyboard_double_arrow_right_sharp,
            size: 30,
            color: context.colorTheme.textMain.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
