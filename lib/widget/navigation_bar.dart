import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';
import 'brightness_button.dart';
import 'glass_container.dart';

class FloatingNavigationBar extends StatefulWidget {
  const FloatingNavigationBar({super.key});

  @override
  State<FloatingNavigationBar> createState() => _FloatingNavigationBarState();
}

class _FloatingNavigationBarState extends State<FloatingNavigationBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      spacing: 12,
      children: [
        GlassContainer(
          padding: const EdgeInsets.all(10),
          child: Column(
            spacing: 12,
            children: [
              _buildNavItem(0, Icons.person_outline, "ABOUT ME"),
              _buildSpacer(context.colorTheme.outline),
              _buildNavItem(1, Icons.rocket_launch_outlined, "PROJECTS"),
            ],
          ),
        ),
        const ThemeToggleButton(),
      ],
    );
  }

  Widget _buildSpacer(Color color) {
    return ColoredBox(
      color: color.withValues(alpha: 0.1),
      child: SizedBox(height: 1, width: 24),
    );
  }

  // 네비게이션 아이템 빌더
  Widget _buildNavItem(int index, IconData icon, String label) {
    int selectedIndex = 0; // This should be managed by the state
    bool isActive = selectedIndex == index;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF6366F1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isActive
              ? Colors.white
              : context.colorTheme.textSub,
          size: 20,
        ),
      ),
    );
  }
}

class NavigationBarLocation extends FloatingActionButtonLocation {
  const NavigationBarLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double buttonX = 30.0 + scaffoldGeometry.minViewPadding.left;
    final double buttonY =
        (scaffoldGeometry.scaffoldSize.height / 2) -
        (scaffoldGeometry.floatingActionButtonSize.height / 2);

    return Offset(buttonX, buttonY);
  }
}
