import 'package:flutter/material.dart';

extension BrightnessExtension on Brightness {
  Brightness get opposite {
    return this == Brightness.light ? Brightness.dark : Brightness.light;
  }

  ThemeMode get themeMode {
    return this == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isLight {
    return this == Brightness.light;
  }
}