import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../extension/theme_extension.dart';
import '../theme/color_theme.dart';
import 'badge_icon.dart';
import 'bento_container.dart';
import 'chip.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.icon,
    required this.titleLabel,
    required this.subTitle,
    this.title,
    this.description,
    this.personnel,
    this.contribution,
    this.skills = const [],
  });

  final IconData icon;
  final String titleLabel;
  final String subTitle;
  final String? title;
  final String? description;
  final int? personnel;
  final double? contribution;
  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: BentoContainer.cardPadding,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            spacing: 8,
            children: [
              BadgeIcon(
                color: context.colorTheme.textSub,
                icon: icon,
              ),
              const Spacer(),
              if (personnel != null)
                IconLabelChip(
                  chipColor: context.chipColorTheme.textMain,
                  style: context.textTheme.labelMedium,
                  icon: Icons.people,
                  label: '개발 $personnel명',
                ),
              if (contribution != null)
                IconLabelChip(
                  chipColor: context.chipColorTheme.blueAccent,
                  style: context.textTheme.labelMedium,
                  icon: Icons.emoji_events,
                  label: '기여도 ${(contribution! * 100).round()}%',
                ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              titleLabel,
              style: TextStyle(
                color: lightColorTheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 4.0,
                    color: lightColorTheme.secondary.withValues(alpha: 0.4),
                  ),
                ],
              ),
            ),
          ),
          if (title != null) ...[
            const Gap(4),
            Text(
              title!,
              style: context.textTheme.sectionTitle.copyWith(
                color: context.colorTheme.textMain,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 2.0,
                    color: context.colorTheme.textSub.withValues(alpha: 0.2),
                  ),
                ],
              ),
            ),
          ],
          const Gap(4),
          Text(
            subTitle,
            style: context.textTheme.cardTitle.copyWith(
              color: context.colorTheme.textSub,
              shadows: [
                Shadow(
                  offset: Offset(0, 1),
                  blurRadius: 2.0,
                  color: context.colorTheme.textSub.withValues(alpha: 0.2),
                ),
              ],
            ),
          ),
          if (description != null) ...[
            const Gap(12),
            Text(
              description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.sectionDescription.copyWith(
                color: context.colorTheme.textSub,
                fontWeight: FontWeight.w600,
                height: 0,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 4.0,
                    color: context.colorTheme.textSub.withValues(alpha: 0.2),
                  ),
                ],
              ),
            ),
          ],
          const Gap(16),
          Wrap(
            spacing: 8,
            children: skills.map(TagChip.mapped).toList(),
          ),
        ],
      ),
    );
  }
}
