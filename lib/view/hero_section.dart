import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import '../extension/theme_extension.dart';
import '../theme/font_theme.dart';
import '../widget/custom_text.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Animate(
            effects: [
              FadeEffect(
                duration: 500.ms,
                delay: 100.ms,
              ),
              SlideEffect(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
                duration: 500.ms,
                delay: 100.ms,
              ),
            ],
            child: CustomText(
              fontStyle: Pretendard.title,
              color: context.colorTheme.primary,
              text: '안녕하세요. 저는 플러터 개발자',
            ),
          ),
          const Gap(30),
          Animate(
            effects: [
              FadeEffect(
                duration: 500.ms,
                delay: 200.ms,
              ),
              SlideEffect(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
                duration: 500.ms,
                delay: 200.ms,
              ),
            ],
            child: CustomText(
              fontStyle: Pretendard.display,
              color: context.colorTheme.textMain,
              text: '김용민입니다.',
            ),
          ),
          const Gap(24),
          Animate(
            effects: [
              FadeEffect(
                duration: 500.ms,
                delay: 300.ms,
              ),
              SlideEffect(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
                duration: 500.ms,
                delay: 300.ms,
              ),
            ],
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 900),
              child: CustomText(
                fontStyle: Pretendard.display,
                color: context.colorTheme.textSub,
                text: '저는 사용자 친화적인 애플리케이션을\n만들기 위해 야호하는 개발자입니다.',
              ),
            ),
          ),
          const Gap(32),
          Animate(
            effects: [
              FadeEffect(
                duration: 500.ms,
                delay: 400.ms,
              ),
              SlideEffect(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
                duration: 500.ms,
                delay: 400.ms,
              ),
            ],
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: CustomText(
                fontStyle: Pretendard.subtitle,
                color: context.colorTheme.textSub,
                text: '사용자에게 최고의 경험을 제공하는 앱을 개발하고 있습니다.'
                        ' 제 포트폴리오를 방문해 주셔서 진심으로 감사드립니다.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
