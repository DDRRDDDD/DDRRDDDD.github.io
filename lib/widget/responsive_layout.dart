import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  static LayoutSize? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ResponsiveLayoutScope>()
        ?.layoutSize;
  }

  static LayoutSize of(BuildContext context) {
    final LayoutSize? layoutSize = maybeOf(context);

    if (layoutSize == null) {
      throw FlutterError(
        'ResponsiveLayout.of()가 포함된 ResponsiveLayout 부모 위젯을 찾을 수 없습니다.\n'
        '사용한 context: $context',
      );
    }
    return layoutSize;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => _ResponsiveLayoutScope(
        layoutSize: .fromConstraints(constraints),
        child: child,
      ),
    );
  }
}

class _ResponsiveLayoutScope extends InheritedWidget {
  const _ResponsiveLayoutScope({
    super.key,
    required this.layoutSize,
    required super.child,
  });

  final LayoutSize layoutSize;

  @override
  bool updateShouldNotify(_ResponsiveLayoutScope old) {
    return layoutSize != old.layoutSize;
  }
}

enum LayoutSize {
  small,
  medium,
  large;

  factory LayoutSize.fromConstraints(BoxConstraints constraints) {
    return switch (constraints.maxWidth) {
      < 600 => LayoutSize.small,
      < 1200 => LayoutSize.medium,
      _ => LayoutSize.large,
    };
  }
}
