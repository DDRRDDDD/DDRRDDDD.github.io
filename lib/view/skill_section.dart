import 'dart:math';

import 'package:flutter/material.dart';

import '../datasource/svg_manager.dart';
import '../extension/theme_extension.dart';
import '../widget/bouncing_ball_container.dart';
import 'bento_grid.dart';

class SkillSection extends StatelessWidget {
  const SkillSection({super.key});

  @override
  Widget build(BuildContext context) {
    // for (int i = 0; i < skillIconPaths.length; i++) {
    //   final String path = skillIconPaths.elementAt(i);
    //   final PictureInfo pictureInfo = SvgManager().lookup(path)!;
    //
    //   print(pictureInfo.size);
    // }

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
              width: 0.3 + Random().nextDouble() * 0.30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// skill section
// title subTitle 작성
// L 34 M 30 S 26
// svg 높이 너비 맞추기
// 색상 결정 공 색, border color,

// 네비게이션 (제미나이 참고)
// 마우스 호버 애니메이션 (확장/축소)
// 클릭 애니메이션 (축소/확장)
// rive theme toggle 변경 (커스터마이징 후 적용) 좋아요 확인