import 'package:flutter/material.dart';

enum DisplaySize {
  small,
  medium,
  large;

  factory DisplaySize.fromConstraints(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return switch (width) {
      < 600 => DisplaySize.small,
      < 1200 => DisplaySize.medium,
      _ => DisplaySize.large,
    };
  }
}
