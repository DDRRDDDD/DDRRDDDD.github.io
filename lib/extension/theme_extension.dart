import 'package:flutter/material.dart';

import '../theme/color_theme.dart';

extension ThemeShortcuts on BuildContext {
  ColorTheme get colorTheme {
    return Theme.of(this).extension<ColorThemeExtension>()!;
  }
}