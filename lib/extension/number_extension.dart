import 'dart:math' as math;

extension RadianExtension on int {
  double get radian {
    return this * math.pi / 180;
  }
}