import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../extension/theme_extension.dart';
import '../theme/chip_theme.dart';

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

class IconLabelChip extends StatelessWidget {
  const IconLabelChip({
    super.key,
    required this.chipColor,
    required this.style,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final TextStyle style;
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
          horizontal: 8,
          vertical: 4,
        ),
        child: Row(
          spacing: 4,
          mainAxisSize: .min,
          children: [
            FaIcon(
              icon,
              size: style.fontSize,
              color: chipColor.foreground,
            ),
            Text(
              label,
              style: style.copyWith(
                color: chipColor.foreground,
                height: 1.5,
              ),
            ),
          ],
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

  const TagChip.mapped(
    this.tag, {
    super.key,
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
            // color: Colors.grey[200],
            color: context.colorTheme.textSub,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
