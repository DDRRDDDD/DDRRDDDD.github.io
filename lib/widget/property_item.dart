import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../extension/theme_extension.dart';

class PropertyTitle extends StatelessWidget {
  const PropertyTitle({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisSize: .min,
      crossAxisAlignment: .end,
      children: [
        FaIcon(
          icon,
          size: 25,
          color: Colors.grey,
        ),
        Text(
          title,
          style: context.textTheme.cardTitle.copyWith(
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class PropertyListTile extends StatelessWidget {
  const PropertyListTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          FaIcon(
            icon,
            size: 18,
            color: Colors.grey[600],
          ),
          const Gap(10),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
