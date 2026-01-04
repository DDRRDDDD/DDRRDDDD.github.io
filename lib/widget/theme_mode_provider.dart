import 'package:flutter/material.dart';

import '../extension/let_extension.dart';
import 'provider.dart';

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

  static ValueNotifier<Brightness> of(BuildContext context) {
    return Provider.of<ValueNotifier<Brightness>>(context);
  }

  @override
  State<BrightnessProvider> createState() => _BrightnessProviderState();
}

class _BrightnessProviderState extends State<BrightnessProvider> {
  late final ValueNotifier<Brightness> _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = WidgetsBinding.instance
        .platformDispatcher
        .platformBrightness
        .let(ValueNotifier.new);
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ValueNotifier<Brightness>>(
      notifier: _notifier,
      child: Builder(
        builder: _buildWithBrightness,
      ),
    );
  }

  Widget _buildWithBrightness(BuildContext context) {
    final Brightness brightness = BrightnessProvider.of(context).value;

    return widget.builder(context, brightness);
  }
}
