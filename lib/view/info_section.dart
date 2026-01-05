import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../extension/theme_extension.dart';
import '../extension/widget_states_extension.dart';
import '../theme/color_theme.dart';
import '../widget/bento_container.dart';
import '../widget/interactive_scale_detector.dart';

class PersonalInfoBentoCard extends StatelessWidget {
  const PersonalInfoBentoCard({super.key});

  Color get _hoverBorderColor {
    return ColorThemeExtension.indigoVivid.withValues(alpha: 0.3);
  }

  Border? _resolveBorder(BuildContext context) {
    return InteractiveScaleDetector.of(context).value.isHovered
        ? Border.all(color: _hoverBorderColor)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveScaleDetector(
      child: Builder(
        builder: (context) => BentoContainer(
          color: context.colorTheme.surface,
          border: _resolveBorder(context),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                '활동 및 자격 사항',
                style: context.textTheme.timelineTitle.copyWith(
                  color: context.colorTheme.textMain,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Gap(9),
              const _InfoRow(
                label: '오픈소스 기여',
                content: 'WebDriverManager PR',
                icon: FontAwesomeIcons.githubAlt,
                isHighlighted: true,
              ),
              const _InfoRow(
                label: '자격증',
                content: '정보처리산업기사',
                icon: FontAwesomeIcons.stamp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String content;
  final IconData icon;
  final bool isHighlighted;

  const _InfoRow({
    required this.label,
    required this.content,
    required this.icon,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorTheme.outline.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: .start,
          spacing: 8,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w900,
                color: context.colorTheme.textSub.withValues(alpha: 0.5),
              ),
            ),
            Row(
              spacing: 6,
              children: [
                FaIcon(
                  icon,
                  size: context.textTheme.labelSmall.fontSize,
                  color: ColorThemeExtension.indigoVivid,
                ),
                Expanded(
                  child: Text(
                    content,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall.copyWith(
                      height: 1.2,
                      fontWeight: FontWeight.w600,
                      color: isHighlighted
                          ? ColorThemeExtension.indigoVivid
                          : context.colorTheme.textMain,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
