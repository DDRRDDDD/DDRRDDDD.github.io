import 'package:flutter/material.dart';

import '../widget/bento_container.dart';
import '../widget/interactive_scale_detector.dart';

class ProjectMyPortfolioSection extends StatelessWidget {
  const ProjectMyPortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    return InteractiveScaleDetector(
      child: BentoContainer(
        color: Colors.purple,
        child: const Placeholder(
          color: Colors.purpleAccent,
        ),
      ),
    );
  }
}
