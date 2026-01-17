import 'package:flutter/material.dart';

extension DirectionalLayoutContext on BuildContext {
  Offset get endEdgeOffset {
    return switch (Directionality.of(this)) {
      TextDirection.ltr => const Offset(1.0, 0.0),
      TextDirection.rtl => const Offset(-1.0, 0.0),
    };
  }
}

extension SlideSheetTransitionStatus on AnimationStatus {
  static const enteringInterval = Interval(0.0, 100.0 / 300.0, curve: Curves.linear);
  static const exitingInterval = Interval(100.0 / 250.0, 1.0, curve: Curves.linear);

  static const enteringCubic = Cubic(0.2, 0.6, 0.4, 1.0);
  static const exitingCubic = Cubic(0.5, 0, 0.7, 0.2);

  bool get isReverse {
    return AnimationStatus.reverse == this;
  }

  Interval get interval {
    return isReverse ? exitingInterval : enteringInterval;
  }

  Interval get reverseInterval {
    return isReverse ? enteringInterval : exitingInterval;
  }

  Cubic get cubic {
    return isReverse ? exitingCubic : enteringCubic;
  }

  Cubic get reverseCubic {
    return isReverse ? enteringCubic : exitingCubic;
  }
}
