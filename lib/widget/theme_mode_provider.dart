import 'package:flutter/material.dart';

import '../extension/let_extension.dart';

typedef BrightnessBuilder =
    Widget Function(
      BuildContext context,
      Brightness brightness,
    );

class BrightnessProvider extends StatefulWidget {
  const BrightnessProvider({
    super.key,
    required this.builder,
  });

  final BrightnessBuilder builder;

  @override
  State<BrightnessProvider> createState() => _BrightnessProviderState();
}

class _BrightnessProviderState extends State<BrightnessProvider> {
  late final ValueNotifier<Brightness>? _notifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _notifier ??= ValueNotifier(MediaQuery.platformBrightnessOf(context));
  }

  @override
  void dispose() {
    _notifier?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BrightnessModel(
      notifier: _notifier,
      child: Builder(
        builder: _buildWithBrightness,
      ),
    );
  }

  Widget _buildWithBrightness(BuildContext context) {
    final Brightness brightness = BrightnessModel.of(context).value;

    return widget.builder(context, brightness);
  }
}

class BrightnessModel extends InheritedNotifier<ValueNotifier<Brightness>> {
  const BrightnessModel({
    super.key,
    super.notifier,
    required super.child,
  });

  static ValueNotifier<Brightness> of(BuildContext context) {
    final ValueNotifier<Brightness>? notifier = context
        .dependOnInheritedWidgetOfExactType<BrightnessModel>()
        ?.notifier;

    if (notifier != null) {
      return notifier;
    }

    throw FlutterError('상위 위젯 트리에서 BrightnessModel를 찾을 수 없습니다.');
  }
}
