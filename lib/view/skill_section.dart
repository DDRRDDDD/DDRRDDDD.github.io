import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_kit/font_kit.dart';

import '../datasource/svg_manager.dart';
import '../extension/theme_extension.dart';
import '../widget/bento_container.dart';
import '../widget/bouncing_ball_container.dart';

class SkillSection extends StatelessWidget {
  const SkillSection({super.key});

  BallOption _toSkillBallOption(SvgEntry entry) {
    final double scale = BouncingBallController.defaultScale;

    return BallOption(
      pictureInfo: entry.value,
      width: SkillSize.fromPath(entry.key).size / scale,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorTheme.surfaceAlt,
        borderRadius: BentoContainer.borderRadius,
      ),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (_, constraints) => BouncingBallContainer(
              containerSize: constraints.biggest,
              ballOptions: SkillSvgManager().entries
                  .map(_toSkillBallOption)
                  .shuffled(),
            ),
          ),
          Padding(
            padding: BentoContainer.cardPadding,
            child: Column(
              crossAxisAlignment: .start,
              spacing: 10,
              children: [
                Text(
                  Constraints.skills.label,
                  style: context.textTheme.timelineTitle.copyWith(
                    color: context.colorTheme.textMain,
                    fontVariations: const [FontVariation.weight(900)],
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 170,
                  ),
                  child: Text(
                    Constraints.skillDescription.label,
                    style: context.textTheme.labelMedium.copyWith(
                      color: context.colorTheme.textSub,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
