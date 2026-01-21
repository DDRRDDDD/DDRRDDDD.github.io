import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constraint/project.dart';
import '../extension/common_extension.dart';
import '../extension/theme_extension.dart';
import '../extension/widget_states_extension.dart';
import '../theme/chip_theme.dart';
import 'scale_detector.dart';

class LabelChip extends StatelessWidget {
  const LabelChip({
    super.key,
    required this.chipColor,
    required this.label,
  });

  final ChipColor chipColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: chipColor.background,
        shape: StadiumBorder(
          side: BorderSide(
            color: chipColor.border,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        child: Text(
          label,
          style: context.textTheme.heroBadge.copyWith(
            color: chipColor.foreground,
          ),
        ),
      ),
    );
  }
}

class IconLabelChip extends StatelessWidget {
  const IconLabelChip({
    super.key,
    required this.chipColor,
    required this.style,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final TextStyle style;
  final ChipColor chipColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: chipColor.background,
        shape: StadiumBorder(
          side: BorderSide(
            color: chipColor.border,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Row(
          spacing: 4,
          mainAxisSize: .min,
          children: [
            FaIcon(
              icon,
              size: style.fontSize,
              color: chipColor.foreground,
            ),
            Text(
              label,
              style: style.copyWith(
                color: chipColor.foreground,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip({super.key, required this.tag});

  const TagChip.text(this.tag, {super.key});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorTheme.glassOverlay,
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
        border: Border.all(
          color: context.colorTheme.outline,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Text(
          tag,
          style: context.textTheme.labelMedium.copyWith(
            color: context.colorTheme.textSub,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class LinkedTagChip extends StatelessWidget {
  const LinkedTagChip({
    super.key,
    required this.icon,
    required this.tag,
    this.url,
  });

  factory LinkedTagChip.item(LinkItem item) {
    return LinkedTagChip(
      icon: item.icon,
      tag: item.label,
      url: Uri.parse(item.url),
    );
  }

  final IconData icon;
  final String tag;
  final Uri? url;

  @override
  Widget build(BuildContext context) {
    return ScaleDetector(
      onPressUp: () => url?.let(launchUrl),
      child: Builder(
        builder: (context) => AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: ScaleDetector.of(context).value.isHovered
                ? context.colorTheme.background
                : context.colorTheme.glassOverlay,
            borderRadius: const BorderRadius.all(
              Radius.circular(6),
            ),
            border: Border.all(
              color: ScaleDetector.of(context).value.isHovered
                  ? context.colorTheme.secondary
                  : context.colorTheme.outline,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Row(
              spacing: 6,
              mainAxisSize: .min,
              children: [
                FaIcon(
                  icon,
                  size: 18,
                  color: context.colorTheme.textSub,
                ),
                Text(
                  tag,
                  style: context.textTheme.labelMedium.copyWith(
                    color: context.colorTheme.textSub,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
