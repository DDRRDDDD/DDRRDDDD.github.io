import 'package:flutter/material.dart';

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
    final ValueNotifier<ThemeMode>? notifier = context
        .dependOnInheritedWidgetOfExactType<ThemeModel>()
        ?.notifier;

    if (notifier != null) {
      return notifier;
    }

    throw FlutterError('상위 위젯 트리에서 ThemeModeProvider를 찾을 수 없습니다.');
  }
}

extension BrightnessExtension on Brightness {
  ThemeMode get themeMode {
    return this == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }
}
