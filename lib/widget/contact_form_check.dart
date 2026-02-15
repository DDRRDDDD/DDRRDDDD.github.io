import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../datasource/rive_file_manager.dart';
import '../extension/common_extension.dart';
import '../extension/theme_extension.dart';

class ContactFormCheck extends StatefulWidget {
  const ContactFormCheck({super.key});

  @override
  State<ContactFormCheck> createState() => _ContactFormCheckState();
}

class _ContactFormCheckState extends State<ContactFormCheck> {
  late RiveWidgetController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RiveFileManager()
        .file('checkmark.riv')
        .let(RiveWidgetController.new);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.colorTheme.surfaceAlt,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: SizedBox.square(
        dimension: 160,
        child: RiveWidget(
          controller: _controller,
          fit: Fit.cover,
        ),
      ),
    );
  }
}
