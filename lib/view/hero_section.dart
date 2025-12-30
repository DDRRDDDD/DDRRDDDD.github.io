import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';
import '../theme/color_theme.dart';
import '../widget/gradient_text.dart';
import '../widget/label_chip.dart';

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
            LabelChip(
              chipColor: context.chipColorTheme.heroPrimary,
              label: '집요한 문제 해결',
            ),
            LabelChip(
              chipColor: context.chipColorTheme.neutral,
              label: '소통을 설계하는 아키텍처',
            ),
          ],
        ),
        Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Text(
              '안녕하세요,',
              style: context.textTheme.heroTitle.copyWith(
                color: context.colorTheme.textMain,
              ),
            ),
            GradientText(
              '플러터 개발자',
              style: context.textTheme.heroTitle,
              gradient: const LinearGradient(
                colors: [
                  ColorThemeExtension.defaultPrimary,
                  ColorThemeExtension.indigoVivid,
                  ColorThemeExtension.electricMagenta,
                ],
              ),
            ),
            Text(
              '김용민입니다.',
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
            '임시방편은 없습니다. 집요하게 문제의 뿌리를 뽑습니다. \n'
            '27만 명이 사용하는 오픈소스의 오류를 해결하여 기여한 경험이 저를 증명합니다. '
            '단순한 기능 구현을 넘어, 코드로 제품의 신뢰를 쌓는 개발자가 되고 싶습니다.',
            style: context.textTheme.bodyLead.copyWith(
              color: context.colorTheme.textMain,
            ),
          ),
        ),
      ],
    );
  }
}
