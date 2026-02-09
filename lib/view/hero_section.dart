import 'package:flutter/material.dart';
import 'package:font_kit/font_kit.dart';

import '../extension/theme_extension.dart';
import '../theme/color_theme.dart';
import '../widget/gradient_text.dart';
import '../widget/scale_detector.dart';
import '../widget/chip.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      spacing: 24,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ScaleDetector(
              hoverScale: 0.035,
              child: LabelChip(
                chipColor: context.chipColorTheme.heroPrimary,
                label: Constraints.persistentProblemSolving.label,
              ),
            ),
            ScaleDetector(
              hoverScale: 0.035,
              child: LabelChip(
                chipColor: context.chipColorTheme.neutral,
                label: Constraints.architectureDesigningCommunication.label,
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text(
              Constraints.hello.label,
              style: context.textTheme.heroTitle.copyWith(
                color: context.colorTheme.textMain,
              ),
            ),
            GradientText(
              Constraints.flutterDeveloper.label,
              style: context.textTheme.heroTitle.copyWith(
                fontSize: context.textTheme.heroTitle.fontSize! * 1.15,
              ),
              gradient: const LinearGradient(
                colors: [
                  ColorThemeExtension.defaultPrimary,
                  ColorThemeExtension.indigoVivid,
                  ColorThemeExtension.electricMagenta,
                ],
              ),
            ),
            Text(
              Constraints.myName.label,
              style: context.textTheme.heroTitle.copyWith(
                color: context.colorTheme.textMain,
              ),
            ),
          ],
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450,
            minWidth: 300,
          ),
          child: Text(
            Constraints.heroDescription.label,
            style: context.textTheme.bodyLead.copyWith(
              fontVariations: const [FontVariation.weight(550)],
              color: context.colorTheme.textMain,
            ),
          ),
        ),
      ],
    );
  }
}
