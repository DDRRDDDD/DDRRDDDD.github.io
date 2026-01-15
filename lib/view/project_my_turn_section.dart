import 'package:flutter/material.dart';

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
    return ScaleDetector(
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
              const SummaryCard(
                icon: Icons.flag,
                personnel: 2,
                contribution: 0.9,
                titleLabel: 'Main Project',
                title: '마이턴',
                subTitle: '보드게임 모임 플랫폼',
                description: '\'원아워\'의 피벗 프로젝트,\n모임의 규모를 보드게임으로 집중한 애플리케이션',
                skills: ['Flutter', 'Supabase', 'Riverpod', 'GoRouter'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
