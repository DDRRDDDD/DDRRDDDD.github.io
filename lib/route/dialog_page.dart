import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  const DialogPage({
    super.key,
    required this.child,
    this.barrierDismissible = true,
    this.useSafeArea = true,
  });

  final bool barrierDismissible;
  final bool useSafeArea;
  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute<T>(
      context: context,
      settings: this,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
      builder: (_) => child,
    );
  }
}
