// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

abstract interface class ColorTheme {
  Color get primary;
}

class ColorThemeExtension extends ThemeExtension<ColorThemeExtension>
    implements ColorTheme {
  const ColorThemeExtension({required this.delegate});

  final ColorTheme delegate;

  @override
  ColorThemeExtension copyWith({ColorTheme? colorTheme}) {
    return ColorThemeExtension(delegate: colorTheme ?? delegate);
  }

  @override
  ColorThemeExtension lerp(ColorThemeExtension? other, double t) {
    return this;
  }

  @override
  Color get primary {
    return delegate.primary;
  }
}

enum ColorPalette implements ColorTheme {
  light(
    primary: Color(0xFF1E88E5),
  ),
  dark(
    primary: Color(0xFF90CAF9),
  )
  ;

  final Color primary;

  const ColorPalette({
    required this.primary,
  });
}
