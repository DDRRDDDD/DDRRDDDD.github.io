import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.showDivider = true,
  });

  final String title;
  final String? subtitle;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      mainAxisAlignment: .center,
      spacing: 16,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.textTheme.sectionTitle.copyWith(
            color: context.colorTheme.textMain,
          ),
        ),
        if (showDivider)
          Container(
            decoration: ShapeDecoration(
              color: context.colorTheme.primary,
              shape: const StadiumBorder(),
            ),
            width: 60,
            height: 4,
          ),
        if (subtitle != null)
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: context.textTheme.sectionDescription.copyWith(
              color: context.colorTheme.textSub,
            ),
          ),
      ],
    );
  }
}
