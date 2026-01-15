import 'package:flutter/material.dart';

import '../extension/brightness_extension.dart';

const lightGradientTheme = GradientThemeExtension._(
  overlay: LinearGradient(
    begin: .topCenter,
    end: .bottomCenter,
    stops: [0.0, 0.3, 0.65, 1.0],
    colors: [
      Colors.white38,
      Colors.transparent,
      Colors.white38,
      Colors.white60,
    ],
  ),
);
const darkGradientTheme = GradientThemeExtension._(
  overlay: LinearGradient(
    begin: .topCenter,
    end: .bottomCenter,
    stops: [0.0, 0.2, 0.5, 1.0],
    colors: [
      Colors.black54,
      Colors.transparent,
      Colors.black26,
      Colors.black87,
    ],
  ),
);

class GradientThemeExtension extends ThemeExtension<GradientThemeExtension> {
  final Gradient overlay;

  const GradientThemeExtension._({
    required this.overlay,
  });

  factory GradientThemeExtension.from(Brightness brightness) {
    return brightness.isLight ? lightGradientTheme : darkGradientTheme;
  }

  @override
  GradientThemeExtension copyWith({LinearGradient? overlay}) {
    return GradientThemeExtension._(
      overlay: overlay ?? this.overlay,
    );
  }

  @override
  GradientThemeExtension lerp(GradientThemeExtension? other, double t) {
    if (other == null) {
      return this;
    }

    return GradientThemeExtension._(
      overlay: Gradient.lerp(overlay, other.overlay, t)!,
    );
  }
}
