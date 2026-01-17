import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../datasource/rive_file_manager.dart';
import '../extension/brightness_extension.dart';
import '../extension/widget_states_extension.dart';
import '../theme/color_theme.dart';
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
    _controller = RiveWidgetController(RiveFileManager().themeToggle);
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

  Color get _hoverBorderColor {
    return ColorThemeExtension.indigoVivid.withValues(alpha: 0.6);
  }

  Border? _resolveBorder(BuildContext context) {
    return ScaleDetector.of(context).value.isHovered
        ? Border.all(color: _hoverBorderColor)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return ScaleDetector(
      hoverScale: 0.08,
      onPressUp: BrightnessProvider.of(context).toggle,
      child: Builder(
        builder: (context) => GlassContainer(
          width: ThemeToggleButton.buttonSize,
          height: ThemeToggleButton.buttonSize,
          borderRadius: BorderRadius.circular(
            ThemeToggleButton.buttonSize / 2,
          ),
          border: _resolveBorder(context),
          child: SizedBox.square(
            dimension: 20,
            child: RiveWidget(
              controller: _controller,
              fit: Fit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
