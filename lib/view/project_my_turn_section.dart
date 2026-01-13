import 'package:flutter/material.dart';

import '../widget/bento_container.dart';
import '../widget/interactive_scale_detector.dart';

class ProjectMyTurnSection extends StatelessWidget {
  const ProjectMyTurnSection({super.key});

  @override
  Widget build(BuildContext context) {
    return InteractiveScaleDetector(
      child: BentoContainer(
        color: Colors.green,
        child: const Placeholder(
          color: Colors.greenAccent,
        ),
      ),
    );
  }
}
