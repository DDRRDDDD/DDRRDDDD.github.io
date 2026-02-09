import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_kit/font_kit.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../extension/common_extension.dart';
import '../extension/theme_extension.dart';
import '../extension/widget_states_extension.dart';
import '../theme/color_theme.dart';
import '../widget/bento_container.dart';
import '../widget/scale_detector.dart';

class PersonalInfoBentoCard extends StatelessWidget {
  const PersonalInfoBentoCard({super.key});

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
    return ScaleDetector(
      child: Builder(
        builder: (context) => BentoContainer(
          color: context.colorTheme.surface,
          border: _resolveBorder(context),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                Constraints.activitiesAndQualifications.label,
                style: context.textTheme.timelineTitle.copyWith(
                  color: context.colorTheme.textMain,
                  fontVariations: const [FontVariation.weight(900)],
                ),
              ),
              const Gap(9),
              _LinkInfoRow(
                label: Constraints.openSourceContribution.label,
                content: Constraints.webDriverManagerPR.label,
                url: 'https://github.com/bonigarcia/webdrivermanager/pull/1259',
                icon: FontAwesomeIcons.githubAlt,
              ),
              _InfoRow(
                label: Constraints.certification.label,
                content: Constraints.infoProcessingIndustryEngineer.label,
                icon: FontAwesomeIcons.stamp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LinkInfoRow extends StatelessWidget {
  const _LinkInfoRow({
    required this.label,
    required this.content,
    required this.url,
    required this.icon,
  });


  final String label;
  final String content;
  final String url;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Uri.parse(url).let(launchUrl),
        child: _InfoRow(
          isHighlighted: true,
          label: label,
          content: content,
          icon: icon,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.content,
    required this.icon,
    this.isHighlighted = false,
  });

  final String label;
  final String content;
  final IconData icon;
  final bool isHighlighted;

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
                fontVariations: const [FontVariation.weight(900)],
                color: context.colorTheme.textSub.withValues(alpha: 0.5),
              ),
            ),
            Row(
              spacing: 6,
              children: [
                FaIcon(
                  icon,
                  size: context.textTheme.labelMedium.fontSize,
                  color: ColorThemeExtension.indigoVivid,
                ),
                Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelMedium.copyWith(
                    height: 1.2,
                    fontVariations: const [FontVariation.weight(600)],
                    decoration: isHighlighted
                        ? TextDecoration.underline
                        : null,
                    decorationColor: isHighlighted
                        ? ColorThemeExtension.indigoVivid
                        : null,
                    color: isHighlighted
                        ? ColorThemeExtension.indigoVivid
                        : context.colorTheme.textMain,
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
