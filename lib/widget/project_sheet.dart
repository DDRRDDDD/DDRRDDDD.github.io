import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../constraint/project.dart';
import '../datasource/asset_finder.dart';
import '../extension/common_extension.dart';
import '../extension/theme_extension.dart';
import '../theme/color_theme.dart';
import 'chip.dart';
import 'markdown_viewer.dart';
import 'milestone_list.dart';
import 'property_item.dart';

class ProjectSheet extends StatefulWidget {
  static const double contentSpacing = 24;

  const ProjectSheet({
    super.key,
    this.stepIndex,
    required this.project,
  });

  final int? stepIndex;
  final Project project;

  @override
  State<ProjectSheet> createState() => _ProjectSheetState();
}

class _ProjectSheetState extends State<ProjectSheet> {
  late final AutoScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AutoScrollController(
      initialScrollOffset: (widget.stepIndex ?? 0) * 150.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMilestone([int? index]) {
    final GoRouter router = GoRouter.of(context);
    final Uri newUri = router.state.uri.replace(
      queryParameters: {
        if (widget.stepIndex != index) 'step': ?index?.toString(),
      },
    );

    newUri.toString().let(router.go);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surfaceAlt,
      body: GestureDetector(
        onTap: _toggleMilestone,
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: _controller,
          slivers: [
            _ProjectSheetHeader(
              icon: widget.project.primaryIcon,
              title: widget.project.title,
              subTitle: widget.project.subTitle,
            ),
            const SliverGap(12),
            _ProjectProperties(
              project: widget.project,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: ProjectSheet.contentSpacing,
                vertical: 12,
              ),
              sliver: SliverGap(
                1,
                color: context.colorTheme.outline,
              ),
            ),
            MilestoneList(
              currentIndex: widget.stepIndex,
              onToggle: _toggleMilestone,
              controller: _controller,
              contentMargin: ProjectSheet.contentSpacing,
              color: context.colorTheme.textSub,
              milestones: AssetFinder()
                  .selectAssets(widget.project.matchesMarkdown)
                  .map(MilestoneMarkdown.new)
                  .toList(),
            ),
            const SliverGap(20),
          ],
        ),
      ),
    );
  }
}

class _ProjectSheetHeader extends StatelessWidget {
  const _ProjectSheetHeader({
    super.key,
    required this.icon,
    required this.subTitle,
    this.title,
  });

  final IconData icon;
  final String? title;
  final String subTitle;

  String get combinedTitle {
    return title?.isNotEmpty == true ? '$title - $subTitle' : subTitle;
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: context.colorTheme.surfaceAlt,
      surfaceTintColor: context.colorTheme.surfaceAlt,
      titleSpacing: ProjectSheet.contentSpacing,
      title: Row(
        spacing: 8,
        children: [
          Icon(
            icon,
            color: ColorThemeExtension.indigoVivid,
            size: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2.5),
            child: Text(
              combinedTitle,
              maxLines: 1,
              overflow: .ellipsis,
              style: context.textTheme.cardTitle.copyWith(
                color: context.colorTheme.textMain,
              ),
            ),
          ),
        ],
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

class _ProjectProperties extends StatelessWidget {
  const _ProjectProperties({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: ProjectSheet.contentSpacing,
      ),
      sliver: SliverList.list(
        children: [
          PropertyListTile(
            icon: Icons.folder_open_outlined,
            label: "분류",
            child: Wrap(
              spacing: 6,
              children: project.labels.map(TagChip.text).toList(),
            ),
          ),
          PropertyTextTile(
            icon: Icons.person_outline,
            label: '역할',
            value: project.role,
          ),
          PropertyTextTile(
            icon: Icons.calendar_month_outlined,
            label: '기간',
            value: project.period,
          ),
          if (project.hasTeamSummary)
            PropertyTextTile(
              icon: Icons.group_outlined,
              label: '팀 / 기여도',
              value: project.teamDetail!,
            ),
          if (project.references != null)
            PropertyListTile(
              icon: Icons.link_outlined,
              label: '링크',
              child: Wrap(
                spacing: 6,
                children: project.references!.map(LinkedTagChip.item).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
