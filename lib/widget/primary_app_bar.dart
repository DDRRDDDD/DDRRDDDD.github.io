import 'package:flutter/material.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({super.key});

  @override
  Size get preferredSize {
    return const Size.fromHeight(90);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        alignment: .center,
        color: Colors.purpleAccent,
        child: const Text('asdasdasdasd'),
      ),
    );
  }
}

// 92
