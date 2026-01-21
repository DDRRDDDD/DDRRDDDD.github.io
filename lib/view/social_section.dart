import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gap/gap.dart';

import '../extension/common_extension.dart';
import '../extension/number_extension.dart';
import '../extension/theme_extension.dart';
import '../extension/widget_states_extension.dart';
import '../theme/color_theme.dart';
import '../widget/bento_container.dart';
import '../widget/scale_detector.dart';

class SocialSection extends StatelessWidget {
  const SocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: .spaceBetween,
      runAlignment: .spaceBetween,
      spacing: BentoContainer.bentoGap,
      runSpacing: BentoContainer.bentoGap,
      children: [
        _SocialBox(
          onTap: () => Uri
              .parse('https://github.com/DDRRDDDD')
              .let(launchUrl),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.github,
              color: context.colorTheme.textMain,
              size: 40,
            ),
          ),
        ),
        _SocialBox(
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.bloggerB,
              color: context.colorTheme.textMain,
              size: 40,
            ),
          ),
        ),
        const _ContactMeCard(),
      ],
    );
  }
}

class _SocialBox extends StatelessWidget {
  const _SocialBox({
    super.key,
    this.onTap,
    required this.child,
  });

  final VoidCallback? onTap;
  final Widget child;

  Color get _hoverBorderColor {
    return ColorThemeExtension.indigoVivid.withValues(alpha: 0.4);
  }

  Border? _resolveBorder(BuildContext context) {
    return ScaleDetector.of(context).value.isHovered
        ? Border.all(color: _hoverBorderColor)
        : Border.all(color: context.colorTheme.outline);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleDetector(
      hoverScale: 0.06,
      enabled: onTap != null,
      onPressUp: onTap,
      child: Builder(
        builder: (context) => BentoContainer(
          width: BentoContainer.spanWidth(1/2),
          height: BentoContainer.spanHeight(1/2),
          border: _resolveBorder(context),
          color: context.colorTheme.surface,
          child: child,
        ),
      ),
    );
  }
}

class _ContactMeCard extends StatelessWidget {
  const _ContactMeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleDetector(
      onPressUp: () => context.go('/input'),
      child: _AwesomeContainer(
        child: Padding(
          padding: BentoContainer.contentPadding,
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .center,
                children: [
                  Text(
                    '함께 일하고',
                    style: context.textTheme.heroTitle.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '싶습니다',
                    style: context.textTheme.heroTitle.copyWith(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    '작은 제안도 소중히 받겠습니다',
                    style: context.textTheme.labelSmall.copyWith(
                      color: darkColorTheme.textMain.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
              const SizedBox.square(
                dimension: 48,
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: CircleBorder(),
                    shadows: [
                      BoxShadow(
                        blurRadius: 10,
                        color: ColorThemeExtension.shadow,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.envelope,
                      color: ColorThemeExtension.indigoVivid,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AwesomeContainer extends StatelessWidget {
  const _AwesomeContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool isHovered = ScaleDetector.of(context).value.isHovered;

    return SizedBox(
      width: BentoContainer.bentoWidth,
      height: BentoContainer.spanHeight(1/2),
      child: ClipRRect(
        borderRadius: BentoContainer.borderRadius,
        child: ColoredBox(
          color: const Color(0xFF4F46E5),
          child: Stack(
            children: [
              // Top-Left Blob (Purple)
              const Positioned(
                top: -50,
                left: -30,
                child: SizedBox.square(
                  dimension: 180,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Color(0x999C27B0), // opacity 60%
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
              ),
              // Bottom-Right Blob (Blue)
              const Positioned(
                bottom: -50,
                right: -30,
                child: SizedBox.square(
                  dimension: 150,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Color(0x992196F3), // opacity 60%
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 12,
                right: 60,
                child: Transform.rotate(
                  angle: 12.radian,
                  child: FaIcon(
                    FontAwesomeIcons.code,
                    size: 24,
                    color: Colors.white.withValues(
                      alpha: isHovered ? 0.2 : 0.1,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -5,
                left: 40,
                child: Transform.rotate(
                  angle: -12.radian,
                  child: Icon(
                    Icons.terminal,
                    size: 24,
                    color: Colors.white.withValues(
                      alpha: isHovered ? 0.2 : 0.1,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 35,
                left: -10,
                child: Icon(
                  Icons.auto_awesome,
                  size: 40,
                  color: ColorThemeExtension.electricMagenta.withValues(
                    alpha: isHovered ? 0.4 : 0.2,
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
