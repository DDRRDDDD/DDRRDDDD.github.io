import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../extension/widget_states_extension.dart';
import '../widget/bento_container.dart';
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
              // Positioned.fill(
              //   child: Image.network(
              //     "https://images.unsplash.com/"
              //         "photo-1543269865-cbf427effbad?q=80&w=2070&auto=format&fit=crop",
              //     fit: BoxFit.cover,
              //   ),
              // ),
              const SummaryCard(
                icon: Icons.code,
                titleLabel: 'Sub Project',
                subTitle: '이웃과 소소한 모임부터 대화까지',
                skills: ['Flutter', 'Firebase', 'Riverpod'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
