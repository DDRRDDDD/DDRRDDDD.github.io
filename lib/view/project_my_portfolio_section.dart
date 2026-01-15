import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../extension/widget_states_extension.dart';
import '../widget/bento_container.dart';
import '../widget/my_avatar.dart';
import '../widget/scale_detector.dart';
import '../widget/summary_card.dart';

class ProjectMyPortfolioSection extends StatelessWidget {
  const ProjectMyPortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleDetector(
      child: Builder(
        builder: (context) => ProjectContainer(
          isHovered: ScaleDetector.of(context).value.isHovered,
          child: Stack(
            children: [
              // Positioned(
              //   bottom: 0,
              //   right: 0,
              //   child: MyAvatar(),
              // ),
              const SummaryCard(
                icon: Icons.code,
                titleLabel: 'Sub Project',
                subTitle: '플러터 포트폴리오 웹사이트',
                skills: ['Flutter', 'GoRouter', 'Forge2D', 'Rive'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
