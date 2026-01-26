import 'package:flutter/material.dart';

import '../theme/chip_theme.dart';
import '../theme/code_syntax_theme.dart';
import '../theme/color_theme.dart';
import '../theme/gradient_theme.dart';
import '../theme/text_theme.dart';

extension ThemeShortcuts on BuildContext {
  ColorThemeExtension get colorTheme {
    return Theme.of(this).extension<ColorThemeExtension>()!;
  }

  TextThemeExtension get textTheme {
    return Theme.of(this).extension<TextThemeExtension>()!;
  }

  ChipColorThemeExtension get chipColorTheme {
    return Theme.of(this).extension<ChipColorThemeExtension>()!;
  }

  GradientThemeExtension get gradientTheme {
    return Theme.of(this).extension<GradientThemeExtension>()!;
  }

  CodeSyntaxThemeExtension get codeSyntaxTheme {
    return Theme.of(this).extension<CodeSyntaxThemeExtension>()!;
  }
}
