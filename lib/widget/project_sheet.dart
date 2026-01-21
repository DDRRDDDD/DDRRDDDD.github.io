import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constraint/project.dart';
import '../extension/theme_extension.dart';
import 'chip.dart';
import 'markdown_viewer.dart';
import 'project_sheet_header.dart';
import 'property_item.dart';
import 'vertical_stepper.dart';

class ProjectSheet extends StatelessWidget {
  static const double contentSpacing = 24;

  const ProjectSheet({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surfaceAlt,
      body: CustomScrollView(
        slivers: [
          ProjectSheetHeader(
            icon: Icons.smartphone,
            title: project.title,
            subTitle: project.subTitle,
          ),
          const SliverGap(12),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: contentSpacing,
            ),
            sliver: SliverList.list(
              children: [
                PropertyListTile(
                  icon: Icons.folder_open_outlined,
                  label: "분류",
                  child: Wrap(
                    spacing: 6,
                    children: project.labels
                        .map(TagChip.text)
                        .toList(),
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
                if (project.hasReferences)
                  PropertyListTile(
                    icon: Icons.link_outlined,
                    label: '링크',
                    child: Wrap(
                      spacing: 6,
                      children: project.references!
                          .map(LinkedTagChip.item)
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: contentSpacing,
              vertical: 12,
            ),
            sliver: SliverGap(1, color: context.colorTheme.outline),
          ),
          VerticalStepper(
            // currentIndex: 0,
            onStepTapped: (index) {},
            steps: [
              Step(
                title: const Text('Step 1 title', style: TextStyle(color: Colors.white)),
                content: MarkdownViewer(),
              ),
              Step(
                title: const Text('Step 2 title', style: TextStyle(color: Colors.white)),
                content: Container(
                  height: 500,
                  color: Colors.orange,
                  alignment: Alignment.centerLeft,
                  child: const Text('Content for Step 2'),
                ),
              ),
            ],
          ),
          const SliverGap(20),
        ],
      ),
    );
  }
}
