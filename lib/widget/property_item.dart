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
      spacing: 8,
      mainAxisSize: .min,
      crossAxisAlignment: .end,
      children: [
        FaIcon(
          icon,
          size: 25,
          color: Colors.grey,
        ),
        Text(
          combinedTitle,
          style: context.textTheme.cardTitle.copyWith(
            color: Colors.black87,
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
      height: 36,
      child: Row(
        children: [
          FaIcon(
            icon,
            size: 18,
            color: context.colorTheme.textSub,
          ),
          const Gap(10),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: context.textTheme.heroBadge.copyWith(
                color: context.colorTheme.textMain,
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
        style: const TextStyle(color: Colors.black87),
      ),
    );
  }
}

