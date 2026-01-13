import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';
import '../theme/chip_color_theme.dart';

class LabelChip extends StatelessWidget {
  const LabelChip({
    super.key,
    required this.chipColor,
    required this.label,
  });

  final ChipColor chipColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: chipColor.background,
        shape: StadiumBorder(
          side: BorderSide(
            color: chipColor.border,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        child: Text(
          label,
          style: context.textTheme.heroBadge.copyWith(
            color: chipColor.foreground,
          ),
        ),
      ),
    );
  }
}

class BadgeChip extends StatelessWidget {
  const BadgeChip({
    super.key,
    required this.chipColor,
    required this.icon,
    required this.label,
  });

  final ChipColor chipColor;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: chipColor.background,
        shape: StadiumBorder(
          side: BorderSide(
            color: chipColor.border,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        child: Text(
          label,
          style: context.textTheme.heroBadge.copyWith(
            color: chipColor.foreground,
          ),
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.tag,
  });

  final String tag;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorTheme.glassOverlay,
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
        border: Border.all(
          color: context.colorTheme.outline,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Text(
          tag,
          style: context.textTheme.labelMedium.copyWith(
            color: context.colorTheme.textSub,
          ),
        ),
      ),
    );
  }
}
