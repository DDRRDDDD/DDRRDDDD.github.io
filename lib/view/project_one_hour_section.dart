import 'package:flutter/material.dart';

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
    return ScaleDetector(
      onTap: () {},
      child: Builder(
        builder: (context) => ProjectContainer(
          isHovered: ScaleDetector.of(context).value.isHovered,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/image/one-hour.jpg',
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
              const SummaryCard(
                icon: Icons.smartphone,
                personnel: 2,
                contribution: 0.3,
                titleLabel: 'Main Project',
                title: '원아워',
                subTitle: '이웃과 소소한 모임부터 대화까지',
                description:
                    '시간 남을 때 근처 사람과 가볍게 만날 수 있는 번개 모임 및 이웃 연결 대화 서비스입니다.',
                skills: ['Flutter', 'Firebase', 'Riverpod'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
