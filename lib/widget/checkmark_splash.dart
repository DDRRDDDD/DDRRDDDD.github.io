import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';

import '../datasource/rive_file_manager.dart';
import '../extension/common_extension.dart';

class CheckmarkSplash extends StatefulWidget {
  const CheckmarkSplash({super.key});

  @override
  State<CheckmarkSplash> createState() => _CheckmarkSplashState();
}

class _CheckmarkSplashState extends State<CheckmarkSplash> {
  late RiveWidgetController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RiveFileManager()
        .file('checkmark.riv')
        .let(RiveWidgetController.new);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.pop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox.square(
        dimension: 320,
        child: RiveWidget(
          controller: _controller,
          fit: Fit.contain,
        ),
      ),
    );
  }
}
