import 'package:flutter/material.dart';

import '../widget/responsive_layout.dart';

class IntroductionSection extends StatelessWidget {
  const IntroductionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      height: MediaQuery.sizeOf(context).height * 0.9,
      width: double.infinity,
      child: Center(child: Text(ResponsiveLayout.of(context).name)),
    );
  }
}
