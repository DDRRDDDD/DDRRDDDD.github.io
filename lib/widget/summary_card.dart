import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../extension/theme_extension.dart';
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
                  chipColor: context.chipStyleTheme.textMain,
                  style: context.textTheme.labelMedium,
                  icon: Icons.people,
                  label: '개발 $personnel명',
                ),
              if (contribution != null)
                IconLabelChip(
                  chipColor: context.chipStyleTheme.blueAccent,
                  style: context.textTheme.labelMedium,
                  icon: Icons.emoji_events,
                  label: '기여도 ${(contribution! * 100).round()}%',
                ),
            ],
          ),
          const Spacer(),
          Text(
            titleLabel,
            style: TextStyle(
              color: context.colorTheme.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          if (title != null) ...[
            const Gap(8),
            Text(
              title!,
              style: context.textTheme.sectionTitle.copyWith(
                color: context.colorTheme.textMain,
              ),
            ),
          ],
          const Gap(4),
          Text(
            subTitle,
            style: context.textTheme.cardTitle.copyWith(
              color: context.colorTheme.textSub,
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
                height: 0,
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
