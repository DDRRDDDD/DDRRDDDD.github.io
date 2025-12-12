import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../extension/theme_extension.dart';
import '../theme/chip_color_theme.dart';
import '../widget/grid_dot_background.dart';
import '../widget/my_avatar.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridDotContainer(
      dotColor: context.colorTheme.primary.withValues(alpha: 0.3),
      padding: const EdgeInsets.only(
        top: 120,
        bottom: 200,
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: 24,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _HeroChip(
                    chipColor: context.chipColorTheme.heroPrimary,
                    label: '집요한 문제 해결',
                  ),
                  _HeroChip(
                    chipColor: context.chipColorTheme.neutral,
                    label: '소통을 설계하는 아키텍처',
                  ),
                ],
              ),
              Text.rich(
                TextSpan(
                  style: GoogleFonts.notoSansKr(
                    textStyle: context.textTheme.heroTitle,
                    color: context.colorTheme.textMain,
                  ),
                  text: '안녕하세요,\n플러터 개발자\n',
                  children: [
                    TextSpan(
                      style: GoogleFonts.notoSansKr(
                        textStyle: context.textTheme.heroTitle,
                        color: context.colorTheme.primary,
                      ),
                      text: '김용민',
                    ),
                    TextSpan(
                      text: '입니다.',
                    ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                  minWidth: 300,
                ),
                child: Text(
                  '27만 명이 사용하는 오픈소스 WebDriverManager의 Docker 환경 호환성 문제를 해결하여 '
                  '공식 PR을 머지시킨 경험은 이러한 집요함의 결과입니다. '
                  '단순히 기능을 구현하는 것에 그치지 않고, 깊이 있는 원인 분석을 통해 문제를 끝까지 해결합니다.',
                  style: GoogleFonts.notoSansKr(
                    textStyle: context.textTheme.bodyLead,
                    color: context.colorTheme.textMain,
                  ),
                ),
              ),
            ],
          ),
          const MyAvatar(),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({
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
        style: GoogleFonts.notoSansKr(
          textStyle: context.textTheme.heroBadge,
          color: chipColor.foreground,
        ),
      ),
    );
  }
}
