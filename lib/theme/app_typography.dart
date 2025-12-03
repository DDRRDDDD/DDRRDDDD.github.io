import 'package:flutter/material.dart';

class AppTypographies {
  AppTypographies._();

  static const AppTypography headline1 = AppTypography(
    fontWeight: AppTypography.bold,
    letterSpacing: AppTypography.appLetterSpacing,
    fontFamily: AppTypography.appFontFamily,
    fontSize: 24,
    lineHeight: 29,
  );

  static const AppTypography headline2 = AppTypography(
    fontWeight: AppTypography.bold,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 22,
    lineHeight: 29,
  );

  static const AppTypography headline3 = AppTypography(
    fontWeight: AppTypography.bold,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 20,
    lineHeight: 29,
  );

  static const AppTypography headline4 = AppTypography(
    fontWeight: AppTypography.semiBold,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 18,
    lineHeight: 22,
  );

  static const AppTypography subhead1 = AppTypography(
    fontWeight: AppTypography.semiBold,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 20,
    lineHeight: 22,
  );

  static const AppTypography subhead2 = AppTypography(
    fontWeight: AppTypography.bold,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 16,
    lineHeight: 22,
  );

  static const AppTypography subhead3 = AppTypography(
    fontWeight: AppTypography.semiBold,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 14,
    lineHeight: 22,
  );

  static const AppTypography body1 = AppTypography(
    fontWeight: AppTypography.semiBold,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 30,
    lineHeight: 36,
  );

  static const AppTypography body2 = AppTypography(
    fontWeight: AppTypography.medium,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 18,
    lineHeight: 22,
  );

  static const AppTypography body3 = AppTypography(
    fontWeight: AppTypography.medium,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 16,
    lineHeight: 24,
  );

  static const AppTypography body4 = AppTypography(
    fontWeight: AppTypography.semiBold,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 16,
    lineHeight: 24,
  );

  static const AppTypography body5 = AppTypography(
    fontWeight: AppTypography.medium,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 14,
    lineHeight: 17,
  );

  static const AppTypography body6 = AppTypography(
    fontWeight: AppTypography.bold,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 12,
    lineHeight: 16,
  );

  static const AppTypography caption1 = AppTypography(
    fontWeight: AppTypography.medium,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 12,
    lineHeight: 16,
  );

  static const AppTypography caption2 = AppTypography(
    fontWeight: AppTypography.semiBold,
    fontFamily: AppTypography.appFontFamily,
    letterSpacing: AppTypography.appLetterSpacing,
    fontSize: 14,
    lineHeight: 16,
  );
}

class AppTypography {
  static const String appFontFamily = 'Pretendard';
  static const double appLetterSpacing = -0.25;

  static const FontVariation bold = FontVariation.weight(700);
  static const FontVariation semiBold = FontVariation.weight(600);
  static const FontVariation medium = FontVariation.weight(500);

  final FontVariation fontWeight;
  final double letterSpacing;
  final String fontFamily;
  final double fontSize;
  final double lineHeight;

  const AppTypography({
    required this.fontWeight,
    required this.letterSpacing,
    required this.fontFamily,
    required this.fontSize,
    required this.lineHeight,
  });

  TextStyle style({Color? color}) {
    return TextStyle(
      color: color ?? Colors.black,
      fontVariations: [fontWeight],
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      fontSize: fontSize,
      height: lineHeight / fontSize,
    );
  }
}
