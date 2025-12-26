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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: ShapeDecoration(
        color: chipColor.background,
        shape: StadiumBorder(
          side: BorderSide(
            color: chipColor.border,
          ),
        ),
      ),
      child: Text(
        label,
        style: context.textTheme.heroBadge.copyWith(
          color: chipColor.foreground,
        ),
      ),
    );
  }
}