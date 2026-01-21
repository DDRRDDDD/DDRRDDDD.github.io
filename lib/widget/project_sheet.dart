import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constraint/project.dart';
import '../extension/theme_extension.dart';
import 'chip.dart';
import 'project_sheet_header.dart';
import 'property_item.dart';
import 'vertical_stepper.dart';

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
  late int? _stepIndex;

  @override
  void initState() {
    super.initState();
    _stepIndex = widget.stepIndex;
  }

  @override
  void didUpdateWidget(ProjectSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stepIndex != widget.stepIndex) {
      _handleStepIndex(widget.stepIndex);
    }
  }

  void _handleStepIndex(int? index) {
    setState(() => _stepIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surfaceAlt,
      body: CustomScrollView(
        slivers: [
          ProjectSheetHeader(
            icon: Icons.smartphone,
            title: widget.project.title,
            subTitle: widget.project.subTitle,
          ),
          const SliverGap(12),
          SliverPadding(
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
                    children: widget.project.labels.map(TagChip.text).toList(),
                  ),
                ),
                PropertyTextTile(
                  icon: Icons.person_outline,
                  label: '역할',
                  value: widget.project.role,
                ),
                PropertyTextTile(
                  icon: Icons.calendar_month_outlined,
                  label: '기간',
                  value: widget.project.period,
                ),
                if (widget.project.hasTeamSummary)
                  PropertyTextTile(
                    icon: Icons.group_outlined,
                    label: '팀 / 기여도',
                    value: widget.project.teamDetail!,
                  ),
                if (widget.project.hasReferences)
                  PropertyListTile(
                    icon: Icons.link_outlined,
                    label: '링크',
                    child: Wrap(
                      spacing: 6,
                      children: widget.project.references!
                          .map(LinkedTagChip.item)
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: ProjectSheet.contentSpacing,
              vertical: 12,
            ),
            sliver: SliverGap(1, color: context.colorTheme.outline),
          ),
          VerticalStepper(
            currentIndex: _stepIndex,
            onStepTapped: _handleStepIndex,
            steps: [
              Step(
                title: const Text(
                  'Step 1 title',
                  style: TextStyle(color: Colors.white),
                ),
                content: Container(
                  height: 300,
                  color: Colors.orange,
                  alignment: Alignment.centerLeft,
                  child: const Text('Content for Step 2'),
                ),
              ),
              Step(
                title: const Text(
                  'Step 2 title',
                  style: TextStyle(color: Colors.white),
                ),
                content: Container(
                  height: 300,
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
