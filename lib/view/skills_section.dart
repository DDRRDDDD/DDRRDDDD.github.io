import 'package:flutter/material.dart';

import '../widget/responsive_layout.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      height: MediaQuery.sizeOf(context).height * 0.9,
      width: double.infinity,
      child: Center(child: Text(ResponsiveLayout.of(context).name)),
    );
  }
}
