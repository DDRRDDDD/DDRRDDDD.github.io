import 'package:flutter/material.dart';
import 'package:font_kit/font_kit.dart';
import 'package:go_router/go_router.dart';

import '../extension/font_kit_extension.dart';
import '../extension/widget_states_extension.dart';
import '../widget/bento_container.dart';
import '../widget/scale_detector.dart';
import '../widget/summary_card.dart';

class ProjectMyPortfolioSection extends StatelessWidget {
  const ProjectMyPortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    const Project project = Project.myPortfolio;

    return ScaleDetector(
      onPressDown: () => context.go('/project/my-portfolio'),
      child: Builder(
        builder: (context) => ProjectContainer(
          isHovered: ScaleDetector.of(context).value.isHovered,
          child: Stack(
            children: [
              SummaryCard(
                icon: project.primaryIcon.data,
                titleLabel: project.type.label,
                subTitle: project.subTitle,
                skills: project.labels,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
