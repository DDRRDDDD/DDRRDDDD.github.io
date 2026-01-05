import 'dart:ui';

import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';

const Radius _defaultRadius = Radius.circular(24);

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    this.width,
    this.height,
    this.border,
    this.borderRadius,
    this.padding,
    required this.child,
  });

  const GlassContainer.bento({
    super.key,
    this.border,
    this.borderRadius,
    this.padding,
    required this.child,
  })  : width = double.infinity,
        height = double.infinity;

  final Widget child;
  final double? width;
  final double? height;
  final Border? border;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius
          ?? const BorderRadius.all(_defaultRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: context.colorTheme.glassOverlay,
            borderRadius: borderRadius
                ?? const BorderRadius.all(_defaultRadius),
            border: border
                ?? Border.all(color: context.colorTheme.outline),
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );
  }
}