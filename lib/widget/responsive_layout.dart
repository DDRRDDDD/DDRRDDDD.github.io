import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScope(
      displaySize: DisplaySize.from(context),
      child: child,
    );
  }
}

class ResponsiveScope extends InheritedWidget {
  const ResponsiveScope({
    super.key,
    required this.displaySize,
    required super.child,
  });

  final DisplaySize displaySize;

  static ResponsiveScope of(BuildContext context) {
    final ResponsiveScope? result = context
        .dependOnInheritedWidgetOfExactType<ResponsiveScope>();

    if (result != null) {
      return result;
    }

    throw FlutterError('No ResponsiveScope found in context');
  }

  @override
  bool updateShouldNotify(ResponsiveScope old) {
    return displaySize != old.displaySize;
  }
}

enum DisplaySize {
  small,
  medium,
  large
  ;

  factory DisplaySize.from(BuildContext context) {
    final double width = MediaQuery.widthOf(context);

    return switch (width) {
      < 600 => DisplaySize.small,
      < 1200 => DisplaySize.medium,
      _ => DisplaySize.large,
    };
  }
}
