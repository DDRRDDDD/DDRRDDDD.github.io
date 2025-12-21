import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../datasource/rive_file_manager.dart';
import '../extension/theme_extension.dart';

class DeveloperBragging extends StatefulWidget {
  const DeveloperBragging({
    super.key,
    this.onTap,
    this.enabled = true,
  });

  final VoidCallback? onTap;
  final bool enabled;

  @override
  State<DeveloperBragging> createState() => _DeveloperBraggingState();
}

class _DeveloperBraggingState extends State<DeveloperBragging> {
  late RiveWidgetController _controller;
  late ViewModelInstance _viewModel;
  late bool _isPlaying;

  @override
  void initState() {
    super.initState();

    final File riveFile = RiveFileManager().developBragging;
    _controller = RiveWidgetController(riveFile);
    _viewModel = _controller.dataBind(DataBind.auto());
    _isPlaying = widget.enabled;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel.color('text main')?.value = context.colorTheme.textMain;
    _viewModel.color('background')?.value = context.colorTheme.background;
  }

  @override
  void didUpdateWidget(DeveloperBragging oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      _isPlaying = widget.enabled;
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TickerMode(
      enabled: _isPlaying,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: SizedBox.square(
            dimension: 55,
            // child: RiveWidget(
            //   controller: _controller,
            //   fit: Fit.cover,
            // ),
          ),
        ),
      ),
    );
  }
}
