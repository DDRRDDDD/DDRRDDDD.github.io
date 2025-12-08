import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import '../extension/theme_extension.dart';
import '../theme/font_theme.dart';
import 'custom_text.dart';
import 'main_app_bar_leading.dart';

class MainAppBarDelegate extends SliverPersistentHeaderDelegate {
  const MainAppBarDelegate({
    required this.labels,
    this.onMenuTap,
  });

  final List<String> labels;
  final ValueChanged<int>? onMenuTap;

  @override
  double get maxExtent {
    return 80.0;
  }

  @override
  double get minExtent {
    return 0.0;
  }

  @override
  bool shouldRebuild(MainAppBarDelegate oldDelegate) {
    return oldDelegate.onMenuTap != onMenuTap;
  }

  int get _computeItemLength {
    return labels.length * 2 - 1;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, _) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.95,
            child: Row(
              children: [
                AppBarLeading(
                  onTap: () => onMenuTap?.call(0),
                  enabled: shrinkOffset < maxExtent,
                ),
                const Spacer(),
                ...List.generate(
                  _computeItemLength,
                  (index) => _buildMenuItem(context, index),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, int index) {
    if (index.isOdd) {
      return const Gap(40);
    }

    final int itemIndex = index ~/ 2;

    return Animate(
      effects: [
        FadeEffect(
          duration: 500.ms,
          delay: (itemIndex * 50).ms,
        ),
        SlideEffect(
          begin: const Offset(0, -5),
          end: Offset.zero,
          duration: 500.ms,
          curve: Curves.easeOutQuart,
          delay: (itemIndex * 50).ms,
        ),
      ],
      child: GestureDetector(
        onTap: () => onMenuTap?.call(itemIndex + 1),
        child: CustomHoverText(
          fontStyle: Pretendard.title,
          hoverColor: context.colorTheme.primary,
          text: labels.elementAt(itemIndex),
        ),
      ),
    );
  }
}
