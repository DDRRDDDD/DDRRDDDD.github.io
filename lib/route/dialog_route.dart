import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogPage<T> extends Page<T> {
  final bool barrierDismissible;
  final bool useSafeArea;
  final Widget child;

  const DialogPage({
    super.key,
    required this.child,
    this.barrierDismissible = true,
    this.useSafeArea = true,
  });

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
