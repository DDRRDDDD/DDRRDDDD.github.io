// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

class FontTheme {
  final String? fontFamily;
  final double? letterSpacing;
  final double fontSize;
  final double height;
  final List<FontVariation> fontVariations;

  const FontTheme({
    this.fontFamily,
    this.letterSpacing,
    required this.fontSize,
    required this.height,
    required this.fontVariations,
  });
}

enum Pretendard implements FontTheme {
  display(
    fontWeight: regular,
    fontSize: 57,
    height: 1.12,
  ),
  headline(
    fontWeight: regular,
    fontSize: 32,
    height: 1.25,
  ),
  title(
    fontWeight: medium,
    fontSize: 22,
    height: 1.27,
  ),
  subtitle(
    fontWeight: medium,
    fontSize: 18,
    height: 1.35,
  ),
  body(
    fontWeight: regular,
    fontSize: 16,
    height: 1.50,
  ),
  label(
    fontWeight: medium,
    fontSize: 12,
    height: 1.33,
  )
  ;

  static const FontVariation regular = FontVariation.weight(400);
  static const FontVariation medium = FontVariation.weight(500);
  static const FontVariation semiBold = FontVariation.weight(600);
  static const FontVariation bold = FontVariation.weight(700);

  final double fontSize;
  final double height;
  final FontVariation fontWeight;

  double get letterSpacing => -0.25;

  String get fontFamily => 'Pretendard';

  List<FontVariation> get fontVariations => [fontWeight];

  const Pretendard({
    required this.fontSize,
    required this.height,
    required this.fontWeight,
  });
}