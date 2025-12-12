import 'package:flutter/material.dart';

import '../extension/brightness_extension.dart';

const lightColorTheme = ColorThemeExtension._(
  primary: ColorThemeExtension.defaultPrimary,
  secondary: Color(0xFF42A5F5),
  background: Color(0xFFF9FAFB),
  surface: Color(0xFFFFFFFF),
  surfaceAlt: Color(0xFFF9FAFB),
  textMain: Color(0xFF1F2937),
  textSub: Color(0xFF4B5563),
  outline: Color(0xFFE5E7EB),
);

const darkColorTheme = ColorThemeExtension._(
  primary: ColorThemeExtension.defaultPrimary,
  secondary: Color(0xFF013E73),
  background: Color(0xFF111827),
  surface: Color(0xFF1F2937),
  surfaceAlt: Color(0xFF374151),
  textMain: Color(0xFFF3F4F6),
  textSub: Color(0xFFD1D5DB),
  outline: Color(0xFF1F2937),
);

class ColorThemeExtension extends ThemeExtension<ColorThemeExtension> {
  static const Color defaultPrimary = Color(0xFF02569B);

  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color surfaceAlt;
  final Color textMain;
  final Color textSub;
  final Color outline;

  factory ColorThemeExtension.from(Brightness brightness) {
    return brightness.isLight ? lightColorTheme : darkColorTheme;
  }

  const ColorThemeExtension._({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.textMain,
    required this.textSub,
    required this.outline,
  });

  @override
  ColorThemeExtension copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? surface,
    Color? surfaceAlt,
    Color? textMain,
    Color? textSub,
    Color? outline,
  }) {
    return ColorThemeExtension._(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      textMain: textMain ?? this.textMain,
      textSub: textSub ?? this.textSub,
      outline: outline ?? this.outline,
    );
  }

  @override
  ColorThemeExtension lerp(ColorThemeExtension? other, double t) {
    if (other == null) {
      return this;
    }

    return ColorThemeExtension._(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      textMain: Color.lerp(textMain, other.textMain, t)!,
      textSub: Color.lerp(textSub, other.textSub, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
    );
  }
}
