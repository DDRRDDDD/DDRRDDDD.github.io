import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../extension/theme_extension.dart';
import '../extension/widget_states_extension.dart';
import '../theme/color_theme.dart';
import '../widget/bento_container.dart';
import '../widget/badge_icon.dart';
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
          title: '개선 및 최적화',
          description: '작은 디테일 하나가 사용자 경험의 차이를 만든다고 믿습니다. '
              '렌더링 부하 감소, 리소스 사용 개선 등 결과가 증명될 때까지 집요하게 파고들어 최적화를 완성하고 개선합니다.',
        ),
        _CompetencyCard(
          color: Colors.green,
          icon: FontAwesomeIcons.cubes,
          title: '기술적인 소통',
          description: '아키텍처와 방법론이 단순한 기술 표준을 넘어, 소통의 명확한 기준이 된다는 것을 배웠습니다. '
              '상황에 최적화된 설계로 지속 가능한 미래를 그리며, 코드뿐만 아니라 팀의 커뮤니케이션 흐름까지 설계합니다.',
        ),
        _CompetencyCard(
          color: Colors.purple,
          icon: FontAwesomeIcons.codeBranch,
          title: '다양한 경험',
          description:
            '플러터 역량에 더해 자바 백엔드, 웹, 인프라, 클라이언트 제어까지 폭넓게 경험했습니다. '
            '이러한 다양한 기술적 배경을 제 코드에 녹여내며, 앞으로 마주할 새로운 기술적 도전과 성장의 경험을 기대하고 있습니다.',
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

  Color get _hoverBorderColor {
    return ColorThemeExtension.indigoVivid.withValues(alpha: 0.4);
  }

  Border? _resolveBorder(BuildContext context) {
    return ScaleDetector.of(context).value.isHovered
        ? Border.all(color: _hoverBorderColor)
        : Border.all(color: context.colorTheme.outline);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScaleDetector(
        child: Builder(
          builder: (context) {
            return BentoContainer(
              color: context.colorTheme.surface,
              border: _resolveBorder(context),
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
                      color: context.colorTheme.textSub,
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
