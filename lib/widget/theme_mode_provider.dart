import 'package:flutter/material.dart';

import '../extension/brightness_extension.dart';

class ThemeModeProvider extends StatefulWidget {
  const ThemeModeProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ThemeModeProvider> createState() => _ThemeModeProviderState();
}

class _ThemeModeProviderState extends State<ThemeModeProvider> {
  late final ValueNotifier<ThemeMode> _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier<ThemeMode>(ThemeMode.system);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _notifier.value = MediaQuery.platformBrightnessOf(context).themeMode;
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeModel(
      notifier: _notifier,
      child: widget.child,
    );
  }
}

class ThemeModel extends InheritedNotifier<ValueNotifier<ThemeMode>> {
  const ThemeModel({
    super.key,
    required super.notifier,
    required super.child,
  });

  static ValueNotifier<ThemeMode> of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeModel>()!.notifier!;
  }
}
