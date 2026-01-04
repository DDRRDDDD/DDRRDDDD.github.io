import 'package:flutter/material.dart';

class Provider<T extends Listenable> extends InheritedNotifier<T> {
  const Provider({
    super.key,
    required super.child,
    required super.notifier,
  });

  static T of<T extends Listenable>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<Provider<T>>();

    if (provider == null) {
      throw Exception("상위 위젯 트리에서 $T를 찾을 수 없습니다.");
    }

    return provider.notifier!;
  }
}