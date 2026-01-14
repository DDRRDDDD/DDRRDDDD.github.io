import 'package:flutter/material.dart';

import '../theme/chip_theme.dart';
import '../theme/color_theme.dart';
import '../theme/text_theme.dart';

extension ThemeShortcuts on BuildContext {
  ColorThemeExtension get colorTheme {
    return Theme.of(this).extension<ColorThemeExtension>()!;
  }

  TextThemeExtension get textTheme {
    return Theme.of(this).extension<TextThemeExtension>()!;
  }

  ChipColorThemeExtension get chipStyleTheme {
    return Theme.of(this).extension<ChipColorThemeExtension>()!;
  }
}
