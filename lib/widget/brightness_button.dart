import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../datasource/rive_file_manager.dart';
import '../extension/brightness_extension.dart';
import '../extension/common_extension.dart';
import '../extension/widget_states_extension.dart';
import 'glass_container.dart';
import 'scale_detector.dart';
import 'theme_mode_provider.dart';

class ThemeToggleButton extends StatefulWidget {
  static const double buttonSize = 56.0;

  const ThemeToggleButton({super.key});

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton> {
  late RiveWidgetController _controller;
  late ViewModelInstance _viewModel;

  @override
  void initState() {
    super.initState();
    _controller = RiveFileManager()
        .file('theme_toggle.riv')
        .let(RiveWidgetController.new);
    _viewModel = _controller.dataBind(DataBind.auto());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel.boolean('isLight')?.value =
        BrightnessProvider.of(context).value.isLight;
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleDetector(
      hoverScale: 0.08,
      onPressUp: BrightnessProvider.of(context).toggle,
      builder: (context, states) => GlassContainer(
        width: ThemeToggleButton.buttonSize,
        height: ThemeToggleButton.buttonSize,
        borderRadius: BorderRadius.circular(
          ThemeToggleButton.buttonSize / 2,
        ),
        border: states.hoverBorder(context),
        child: SizedBox.square(
          dimension: 20,
          child: RiveWidget(
            controller: _controller,
            fit: Fit.cover,
          ),
        ),
      ),
    );
  }
}
