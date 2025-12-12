import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';
import '../widget/section_title.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

  @override
  Widget build(BuildContext context) {

    return ColoredBox(
      color: context.colorTheme.surface,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 200,
        ),
        child: SizedBox(
          height: 1000,
          child: Column(
            mainAxisAlignment: .center,
            spacing: 60,
            children: [
              const SectionTitle(
                title: 'Core Competencies',
                subtitle: '이유 없는 기술은 쓰지 않습니다. '
                    '오직 문제 해결과 원활한 소통을 위해 깊이 파고듭니다.',
              ),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: .center,
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
