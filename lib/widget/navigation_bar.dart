import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../extension/theme_extension.dart';
import '../extension/widget_states_extension.dart';
import '../theme/color_theme.dart';
import 'brightness_button.dart';
import 'glass_container.dart';
import 'interactive_scale_detector.dart';

class FloatingNavigationBar extends StatefulWidget {
  const FloatingNavigationBar({super.key});

  @override
  State<FloatingNavigationBar> createState() => _FloatingNavigationBarState();
}

class _FloatingNavigationBarState extends State<FloatingNavigationBar>
    with SingleTickerProviderStateMixin {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  void _onItemChanged(int index) {
    setState(() =>_selectedIndex = index);
  }

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
              _NavigationItem(
                index: 0,
                selectedIndex: _selectedIndex,
                onChanged: _onItemChanged,
                icon: Icons.person_outline,
                label: 'ABOUT ME',
              ),
              Gap(
                1,
                crossAxisExtent: 24,
                color: context.colorTheme.outline.withValues(alpha: 0.1),
              ),
              _NavigationItem(
                index: 1,
                selectedIndex: _selectedIndex,
                onChanged: _onItemChanged,
                icon: Icons.rocket_launch_outlined,
                label: 'PROJECTS',
              ),
            ],
          ),
        ),
        const ThemeToggleButton(),
      ],
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    super.key,
    this.onChanged,
    required this.index,
    required this.selectedIndex,
    required this.icon,
    required this.label,
  });

  final ValueChanged<int>? onChanged;
  final int index;
  final int selectedIndex;
  final IconData icon;
  final String label;

  bool get _isSelected {
    return index == selectedIndex;
  }

  Color _resolveBoxColor(BuildContext context) {
    return _isSelected
        ? ColorThemeExtension.indigoVivid
        : Colors.transparent;
  }

  Color _resolveLabelColor(BuildContext context) {
    final WidgetStates states = InteractiveScaleDetector.of(context).value;

    if (!states.isHovered) {
      return context.colorTheme.textSub;
    }

    return _isSelected ? Colors.white : ColorThemeExtension.indigoVivid;
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveScaleDetector(
      hoverScale: _isSelected ? 0.08 : 0.16,
      onTap: () => onChanged?.call(index),
      child: Builder(
        builder: (context) => AnimatedContainer(
          height: 40,
          width: 40,
          curve: Curves.easeOutCubic,
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: _resolveBoxColor(context),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: _resolveLabelColor(context),
            size: 20,
          ),
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
