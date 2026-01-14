import 'package:flutter/material.dart';

import '../extension/brightness_extension.dart';
import 'color_theme.dart';
import 'text_theme.dart';

const lightColorTheme = ChipColorThemeExtension._(
  heroPrimary: ChipColor(
    foreground: ColorThemeExtension.defaultPrimary,
    background: Color(0xFFDBEAFE),
    border: Color(0xFFBFDBFE),
  ),
  neutral: ChipColor(
    foreground: Color(0xFF374151),
    background: Color(0xFFF3F4F6),
    border: Color(0xFFE5E7EB),
  ),
  textMain: ChipColor(
    foreground: Color(0xFF616161),
    background: Color(0xFFF5F5F5),
    border: Color(0xFFE0E0E0),
  ),
  blueAccent: ChipColor(
    foreground: Color(0xFF42A5F5),
    background: Color(0x1A2196F3),
    border: Color(0x332196F3),
  ),
);

const darkColorTheme = ChipColorThemeExtension._(
  heroPrimary: ChipColor(
    foreground: ColorThemeExtension.defaultPrimary,
    background: Color(0x4D1E3A8A),
    border: Color(0xFF1E40AF),
  ),
  neutral: ChipColor(
    foreground: Color(0xFFD1D5DB),
    background: Color(0xFF1F2937),
    border: Color(0xFF374151),
  ),
  textMain: ChipColor(
    foreground: Color(0xFFE0E0E0),
    background: Color(0x0DFFFFFF),
    border: Color(0x1AFFFFFF),
  ),
  blueAccent: ChipColor(
    foreground: Color(0xFF42A5F5),
    background: Color(0x332196F3),
    border: Color(0x662196F3),
  ),
);

class ChipColorThemeExtension extends ThemeExtension<ChipColorThemeExtension> {
  static const Color defaultPrimary = Color(0xFF02569B);

  final ChipColor heroPrimary;
  final ChipColor neutral;
  final ChipColor textMain;
  final ChipColor blueAccent;

  factory ChipColorThemeExtension.from(Brightness brightness) {
    return brightness.isLight ? lightColorTheme : darkColorTheme;
  }

  const ChipColorThemeExtension._({
    required this.heroPrimary,
    required this.neutral,
    required this.textMain,
    required this.blueAccent,
  });

  @override
  ChipColorThemeExtension copyWith({
    ChipColor? heroPrimary,
    ChipColor? neutral,
    ChipColor? textMain,
    ChipColor? blueAccent,
  }) {
    return ChipColorThemeExtension._(
      heroPrimary: heroPrimary ?? this.heroPrimary,
      neutral: neutral ?? this.neutral,
      textMain: textMain ?? this.textMain,
      blueAccent: blueAccent ?? this.blueAccent,
    );
  }

  @override
  ChipColorThemeExtension lerp(ChipColorThemeExtension? other, double t) {
    if (other == null) {
      return this;
    }

    return ChipColorThemeExtension._(
      heroPrimary: heroPrimary.lerp(other.heroPrimary, t),
      neutral: neutral.lerp(other.neutral, t),
      textMain: textMain.lerp(other.textMain, t),
      blueAccent: blueAccent.lerp(other.blueAccent, t),
    );
  }
}

class ChipColor {
  final Color foreground;
  final Color background;
  final Color border;

  const ChipColor({
    required this.foreground,
    required this.background,
    required this.border,
  });

  ChipColor lerp(ChipColor other, double t) {
    return ChipColor(
      foreground: Color.lerp(foreground, other.foreground, t)!,
      background: Color.lerp(background, other.background, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}
