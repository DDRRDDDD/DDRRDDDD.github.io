import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../extension/theme_extension.dart';

class PropertyTitle extends StatelessWidget {
  const PropertyTitle({
    super.key,
    required this.icon,
    required this.subTitle,
    this.title,
  });

  final IconData icon;
  final String? title;
  final String subTitle;

  String get combinedTitle {
    return (title != null && title!.isNotEmpty)
        ? '$title - $subTitle'
        : subTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisSize: .min,
      crossAxisAlignment: .end,
      children: [
        FaIcon(
          icon,
          size: context.textTheme.cardTitle.fontSize! * 1.25,
          color: context.colorTheme.textMain.withValues(alpha: 0.6),
        ),
        Text(
          combinedTitle,
          style: context.textTheme.cardTitle.copyWith(
            color: context.colorTheme.textMain,
          ),
        ),
      ],
    );
  }
}

class PropertyListTile extends StatelessWidget {
  const PropertyListTile({
    super.key,
    required this.icon,
    required this.label,
    required this.child,
  });

  final IconData icon;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          FaIcon(
            icon,
            size: 18,
            color: context.colorTheme.textSub.withValues(
              alpha: 0.6,
            ),
          ),
          const Gap(10),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 100,
            ),
            child: Text(
              label,
              style: context.textTheme.heroBadge.copyWith(
                color: context.colorTheme.textMain.withValues(
                  alpha: 0.8,
                ),
              ),
            ),
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

class PropertyTextTile extends StatelessWidget {
  const PropertyTextTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return PropertyListTile(
      icon: icon,
      label: label,
      child: Text(
        value,
        style: context.textTheme.bodyRegular.copyWith(
          fontVariations: [FontVariation.weight(600)],
          color: context.colorTheme.textMain,
        ),
      ),
    );
  }
}
