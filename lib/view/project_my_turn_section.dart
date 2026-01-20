import 'package:flutter/material.dart';

import '../constraint/project.dart';
import '../extension/image_extension.dart';
import '../extension/theme_extension.dart';
import '../extension/widget_states_extension.dart';
import '../widget/bento_container.dart';
import '../widget/scale_detector.dart';
import '../widget/summary_card.dart';

class ProjectMyTurnSection extends StatelessWidget {
  const ProjectMyTurnSection({super.key});

  @override
  Widget build(BuildContext context) {
    const Project project = Project.myTurn;

    return ScaleDetector(
      onPressUp: () {},
      child: Builder(
        builder: (context) => ProjectContainer(
          isHovered: ScaleDetector.of(context).value.isHovered,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/image/my-turn.jpg',
                  cacheWidth: BentoContainer.spanWidth(2).cacheSize(context),
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
