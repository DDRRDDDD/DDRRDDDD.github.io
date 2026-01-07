import 'package:flutter/material.dart';

import '../datasource/svg_manager.dart';
import '../extension/theme_extension.dart';
import '../widget/bento_container.dart';
import '../widget/bouncing_ball_container.dart';

class SkillSection extends StatelessWidget {
  const SkillSection({super.key});

  BallOption _toSkillBallOption(SkillOptions skill) {
    return BallOption(
      pictureInfo: SvgManager().lookup(skill.assetPath),
      width: skill.size / BouncingBallController.defaultScale,
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
              ballOptions: SkillOptions.values
                  .map(_toSkillBallOption)
                  .toList()
                ..shuffle(),
            ),
          ),
          Padding(
            padding: BentoContainer.cardPadding,
            child: Column(
              crossAxisAlignment: .start,
              spacing: 10,
              children: [
                Text(
                  '보유 기술',
                  style: context.textTheme.timelineTitle.copyWith(
                    color: context.colorTheme.textMain,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 170,
                  ),
                  child: Text(
                    '부딪히며 습득하고,\n끊임없이 경험을 쌓아 올렸습니다.',
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

enum SkillOptions {
  copilot(_smallSize),
  css(_smallSize),
  figma(_smallSize),
  gemini(_smallSize),
  githubactions(_smallSize),
  html(_smallSize),
  js(_smallSize),
  mariadb(_smallSize),
  mysql(_smallSize),
  nginx(_smallSize),
  selenium(_smallSize),
  slack(_smallSize),
  ubuntu(_smallSize),
  rive(_smallSize),
  docker(_mediumSize),
  jenkins(_mediumSize),
  firebase(_mediumSize),
  supabase(_mediumSize),
  github(_mediumSize),
  riverpod(_largeSize),
  dart(_largeSize),
  flutter(_largeSize),
  java(_largeSize),
  spring(_largeSize),
  ;

  static const double _largeSize = 60.0;
  static const double _mediumSize = 52.0;
  static const double _smallSize = 44.0;

  final double size;

  static List<String> get allAssetPaths {
    return SkillOptions.values.map((skill) => skill.assetPath).toList();
  }

  String get assetPath {
    return 'assets/skill/$name.svg';
  }

  const SkillOptions(this.size);
}
