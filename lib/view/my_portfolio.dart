import 'package:flutter/material.dart';

import '../widget/my_avatar.dart';

class MyPortfolioScreen extends StatelessWidget {
  const MyPortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('나의 포트폴리오'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 100),
          MyAvatar(),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}