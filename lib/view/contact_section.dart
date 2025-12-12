import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorTheme.surface,
      child: SizedBox(
        height: 1000,
      ),
    );
  }
}
