import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BorderIcon extends StatelessWidget {
  const BorderIcon({
    super.key,
    required this.icon,
    this.padding = const EdgeInsets.all(8),
    this.size,
    this.color,
  });

  final IconData icon;
  final EdgeInsets padding;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color?.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(
          color: color?.withValues(alpha: 0.3) ?? Colors.transparent,
        ),
      ),
      child: Padding(
        padding: padding,
        child: FaIcon(
          icon,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
