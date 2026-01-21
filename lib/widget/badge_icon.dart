import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BadgeIcon extends StatelessWidget {
  const BadgeIcon({
    super.key,
    required this.icon,
    required this.color,
    this.padding = const EdgeInsets.all(8),
    this.size,
  });

  final IconData icon;
  final Color color;
  final EdgeInsets padding;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.35),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(
          color: color.withValues(alpha: 0.7),
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
