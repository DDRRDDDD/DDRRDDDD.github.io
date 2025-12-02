import 'package:flutter/material.dart';

import '../widget/responsive_layout.dart';

class SubProjectSection extends StatelessWidget {
  const SubProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: MediaQuery.sizeOf(context).height * 0.9,
      width: double.infinity,
      child: Center(child: Text(ResponsiveLayout.of(context).name)),
    );
  }
}
