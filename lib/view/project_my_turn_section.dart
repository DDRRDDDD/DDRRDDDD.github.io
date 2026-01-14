import 'package:flutter/material.dart';

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
              // Positioned.fill(
              //   child: Image.network(
              //     "https://images.unsplash.com/"
              //         "photo-1543269865-cbf427effbad?q=80&w=2070&auto=format&fit=crop",
              //     fit: BoxFit.cover,
              //   ),
              // ),
              const SummaryCard(
                icon: Icons.smartphone,
                personnel: 2,
                contribution: 0.9,
                titleLabel: 'Main Project',
                title: '마이턴',
                subTitle: '보드게임 모임 플랫폼',
                description: '\'원아워\'의 피벗 프로젝트,\n모임의 규모를 보드게임으로 집중한 애플리케이션',
                skills: ['Flutter', 'Supabase', 'Riverpod', 'Go Router'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
