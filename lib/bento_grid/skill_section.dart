import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../datasource/svg_manager.dart';
import '../extension/theme_extension.dart';
import '../widget/bouncing_ball_container.dart';
import 'bento_grid.dart';

class SkillSection extends StatelessWidget {
  const SkillSection({super.key});

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < skillIconPaths.length; i++) {
      _skillBallOption(i);
    }

    return Container(
      decoration: BoxDecoration(
        color: context.colorTheme.surfaceAlt,
        borderRadius: BentoContainer.borderRadius,
      ),
      child: LayoutBuilder(
        builder: (_, constraints) => BouncingBallContainer(
          containerSize: constraints.biggest,
          ballOptions: List.generate(
            skillIconPaths.length,
            (index) => BallOption(
              pictureInfo: SvgManager().lookup(skillIconPaths.elementAt(index)),
              width: 0.30 + Random().nextDouble() * 0.30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _skillBallOption(int index) {
    final String path = skillIconPaths.elementAt(index);
    final PictureInfo pictureInfo = SvgManager().lookup(path)!;

    print(pictureInfo.size);
  }
}

// L 34 M 30 S 26
// svg 높이 너비 맞추기
// 색상 결정 공 색, border color,
