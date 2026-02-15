import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_kit/font_kit.dart';

import '../extension/theme_extension.dart';
import '../extension/widget_states_extension.dart';
import '../widget/badge_icon.dart';
import '../widget/bento_container.dart';
import '../widget/scale_detector.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      spacing: BentoContainer.bentoGap,
      children: [
        _CompetencyCard(
          color: Colors.orange,
          icon: FontAwesomeIcons.microchip,
          title: Constraints.improvementAndOptimization.label,
          description: Constraints.improvementDesc.label,
        ),
        _CompetencyCard(
          color: Colors.green,
          icon: FontAwesomeIcons.cubes,
          title: Constraints.technicalCommunication.label,
          description: Constraints.communicationDesc.label,
        ),
        _CompetencyCard(
          color: Colors.purple,
          icon: FontAwesomeIcons.codeBranch,
          title: Constraints.diverseExperience.label,
          description: Constraints.experienceDesc.label,
        ),
      ],
    );
  }
}

class _CompetencyCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  const _CompetencyCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScaleDetector(
        builder: (context, states) => BentoContainer(
          color: context.colorTheme.surface,
          border: states.hoverBorder(context),
          child: Column(
            crossAxisAlignment: .start,
            spacing: 12,
            children: [
              Row(
                spacing: 16,
                children: [
                  BadgeIcon(
                    padding: const EdgeInsets.all(12),
                    size: 24,
                    color: color,
                    icon: icon,
                  ),
                  Text(
                    title,
                    style: context.textTheme.cardTitle.copyWith(
                      color: context.colorTheme.textMain,
                    ),
                  ),
                ],
              ),
              Text(
                description,
                style: context.textTheme.bodyRegular.copyWith(
                  fontVariations: const [FontVariation.weight(500)],
                  color: context.colorTheme.textSub,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
