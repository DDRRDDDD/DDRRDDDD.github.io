import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MyAvatar extends StatefulWidget {
  const MyAvatar({super.key});

  @override
  State<MyAvatar> createState() => _MyAvatarState();
}

class _MyAvatarState extends State<MyAvatar> {
  late RiveWidgetController _controller;
  late bool _isRiveInitialized;

  @override
  void initState() {
    super.initState();
    _isRiveInitialized = false;
    _initRive();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initRive() async {
    final File? riveFile = await File.asset(
      'assets/rive/my_avatar.riv',
      riveFactory: Factory.rive,
    );
    _controller = RiveWidgetController(riveFile!);
    setState(() =>_isRiveInitialized = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isRiveInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Align(
      alignment: Alignment.center,
      child: SizedBox.square(
        dimension: 200,
        child: RiveWidget(
          controller: _controller,
          fit: Fit.cover,
        ),
      ),
    );
  }
}
