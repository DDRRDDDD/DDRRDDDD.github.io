import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../extension/theme_extension.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      mainAxisAlignment: .center,
      spacing: 16,
      children: [
        Text(
          title,
          style: GoogleFonts.notoSansKr(
            textStyle: context.textTheme.sectionTitle,
            color: context.colorTheme.textMain,
          ),
        ),
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
            style: GoogleFonts.notoSansKr(
              textStyle: context.textTheme.sectionDescription,
              color: context.colorTheme.textSub,
            ),
          ),
      ],
    );
  }
}
