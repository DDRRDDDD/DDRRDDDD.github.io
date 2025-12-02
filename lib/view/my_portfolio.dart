import 'package:flutter/material.dart';

class MyPortfolioScaffold extends StatelessWidget {
  const MyPortfolioScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('나의 포트폴리오'),
      ),
      body: child,
    );
  }
}
