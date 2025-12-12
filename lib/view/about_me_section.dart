import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../extension/theme_extension.dart';
import '../widget/section_title.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      color: context.colorTheme.surface,
      padding: EdgeInsets.symmetric(
        vertical: 150,
      ),
      child: Column(
        mainAxisAlignment: .center,
        spacing: 60,
        children: [
          const SectionTitle(
            title: 'Core Competencies',
            subtitle:
                '이유 없는 기술은 쓰지 않습니다. '
                '오직 문제 해결과 원활한 소통을 위해 깊이 파고듭니다.',
          ),
          const Wrap(
            spacing: 50,
            runSpacing: 25,
            alignment: .center,
            children: [
              _CompetencyCard(
                color: Colors.orange,
                assetPath: _CompetencyCard.microchipAssetPath,
                title: '개선 및 최적화',
                description: '렌더링 부하 90% 감소, 리소스 용량 50% 절감 등 '
                    '수치로 증명될 때까지 집요하게 파고들어 최적화를 해냅니다.',
              ),
              _CompetencyCard(
                color: Colors.green,
                assetPath: _CompetencyCard.cubesAssetPath,
                title: '기술적인 소통',
                description: '아키텍처는 협업의 근거가 된다고 생각합니다. '
                    '같은 개발자는 물론이고 비개발자와도 명확한 소통을 주도합니다. '
                    'TDD, Atomic Design, Clean Architecture를 통해 명확한 소통을 주도합니다.',
              ),
              _CompetencyCard(
                color: Colors.purple,
                assetPath: _CompetencyCard.gitBranchAssetPath,
                title: '다양한 경험',
                description: '혼자 해결하는 것을 넘어 생태계에 기여합니다. '
                    'WebDriverManager 공식 프로젝트에 기여하며 함께 성장합니다.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CompetencyCard extends StatelessWidget {
  static const String microchipAssetPath = 'assets/icon/microchip.svg';
  static const String cubesAssetPath = 'assets/icon/cubes.svg';
  static const String gitBranchAssetPath = 'assets/icon/git-branch.svg';

  final String assetPath;
  final Color color;
  final String title;
  final String description;

  const _CompetencyCard({
    super.key,
    required this.assetPath,
    required this.color,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: context.colorTheme.background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.colorTheme.outline,
        ),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: VectorGraphic(
              loader: AssetBytesLoader(assetPath),
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              width: 30,
              height: 30,
            ),
          ),
          const Gap(24),
          Text(
            title,
            style: GoogleFonts.notoSansKr(
              textStyle: context.textTheme.cardTitle,
              color: context.colorTheme.textMain,
            ),
          ),
          const Gap(12),
          Text(
            description,
            style: GoogleFonts.notoSansKr(
              textStyle: context.textTheme.bodyRegular,
              color: context.colorTheme.textSub,
            ),
          ),
        ],
      ),
    );
  }
}
