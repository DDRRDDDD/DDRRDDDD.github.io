import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../datasource/rive_file_manager.dart';

class MyAvatar extends StatefulWidget {
  const MyAvatar({
    super.key,
    this.size = 200,
  });

  final double size;

  @override
  State<MyAvatar> createState() => _MyAvatarState();
}

class _MyAvatarState extends State<MyAvatar> {
  late RiveWidgetController _controller;

  @override
  void initState() {
    super.initState();

    final File riveFile = RiveFileManager().myAvatarFile;
    _controller = RiveWidgetController(riveFile);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox.square(
        dimension: widget.size,
        child: RiveWidget(
          controller: _controller,
          hitTestBehavior: RiveHitTestBehavior.transparent,
          layoutScaleFactor: 1.0,
          cursor: SystemMouseCursors.click,
          fit: Fit.cover,
        ),
      ),
    );
  }
}
