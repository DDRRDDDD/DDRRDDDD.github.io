import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constraint/project.dart';
import '../extension/image_extension.dart';
import '../extension/theme_extension.dart';
import '../extension/widget_states_extension.dart';
import '../widget/bento_container.dart';
import '../widget/scale_detector.dart';
import '../widget/summary_card.dart';

class ProjectOneHourSection extends StatelessWidget {
  const ProjectOneHourSection({super.key});

  @override
  Widget build(BuildContext context) {
    const Project project = Project.oneHour;

    return ScaleDetector(
      onPressDown: () => context.go('/project/one-hour'),
      child: Builder(
        builder: (context) => ProjectContainer(
          isHovered: ScaleDetector.of(context).value.isHovered,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  project.bannerAssetPath!,
                  cacheHeight: BentoContainer.spanHeight(2).cacheSize(context),
                  fit: .cover,
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: context.gradientTheme.overlay,
                  ),
                ),
              ),
              SummaryCard(
                icon: project.primaryIcon,
                personnel: project.teamSummaries?.length,
                contribution: project.myContribution,
                titleLabel: project.type.label,
                title: project.title,
                subTitle: project.subTitle,
                description: project.description,
                skills: project.labels,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
