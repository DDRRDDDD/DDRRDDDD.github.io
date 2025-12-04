// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import '../extension/brightness_extension.dart';

@immutable
class ColorTheme {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color textMain;
  final Color textSub;
  final Color outline;

  const ColorTheme({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.textMain,
    required this.textSub,
    required this.outline,
  });
}

enum ColorPalette implements ColorTheme {
  light(
    primary: Color(0xFF2563EB),
    secondary: Color(0xFF60A5FA),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    textMain: Color(0xFF1E293B),
    textSub: Color(0xFF64748B),
    outline: Color(0xFFE2E8F0),
  ),
  dark(
    primary: Color(0xFF3B82F6),
    secondary: Color(0xFF93C5FD),
    background: Color(0xFF0F172A),
    surface: Color(0xFF1E293B),
    textMain: Color(0xFFF1F5F9),
    textSub: Color(0xFF94A3B8),
    outline: Color(0xFF334155),
  );

  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color textMain;
  final Color textSub;
  final Color outline;

  const ColorPalette({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.textMain,
    required this.textSub,
    required this.outline,
  });

  factory ColorPalette.fromBrightness(Brightness brightness) {
    return brightness.isLight ? ColorPalette.light : ColorPalette.dark;
  }
}

class ColorThemeExtension extends ThemeExtension<ColorThemeExtension>
    implements ColorTheme {
  const ColorThemeExtension({required this.delegate});

  final ColorTheme delegate;

  Color get primary => delegate.primary;

  Color get secondary => delegate.secondary;

  Color get background => delegate.background;

  Color get surface => delegate.surface;

  Color get textMain => delegate.textMain;

  Color get textSub => delegate.textSub;

  Color get outline => delegate.outline;

  @override
  ColorThemeExtension copyWith({ColorTheme? colorTheme}) {
    return ColorThemeExtension(delegate: colorTheme ?? delegate);
  }

  @override
  ColorThemeExtension lerp(ColorThemeExtension? other, double t) {
    if (other == null) {
      return this;
    }

    return ColorThemeExtension(
      delegate: ColorTheme(
        primary: Color.lerp(primary, other.primary, t)!,
        secondary: Color.lerp(secondary, other.secondary, t)!,
        background: Color.lerp(background, other.background, t)!,
        surface: Color.lerp(surface, other.surface, t)!,
        textMain: Color.lerp(textMain, other.textMain, t)!,
        textSub: Color.lerp(textSub, other.textSub, t)!,
        outline: Color.lerp(outline, other.outline, t)!,
      ),
    );
  }
}
