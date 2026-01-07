import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../extension/theme_extension.dart';
import '../extension/widget_states_extension.dart';
import '../theme/color_theme.dart';
import 'brightness_button.dart';
import 'glass_container.dart';
import 'interactive_scale_detector.dart';

class FloatingNavigationBar extends StatefulWidget {
  const FloatingNavigationBar({
    super.key,
    this.onNavigate,
    this.currentIndex = 0,
    this.items = const [],
  });

  final ValueChanged<int>? onNavigate;
  final int currentIndex;
  final List<NavigationItem> items;

  @override
  State<FloatingNavigationBar> createState() => _FloatingNavigationBarState();
}

class _FloatingNavigationBarState extends State<FloatingNavigationBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(FloatingNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      setState(() => _currentIndex = widget.currentIndex);
    }
  }

  int get _computedItemCount {
    return widget.items.length * 2 - 1;
  }

  void _onNavigate(int itemIndex) {
    setState(() => _currentIndex = itemIndex);
    widget.onNavigate?.call(_currentIndex);
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
            children: List.generate(
              _computedItemCount,
              _buildSeparatedItem,
            ),
          ),
        ),
        const ThemeToggleButton(),
      ],
    );
  }

  Widget _buildSeparatedItem(int index) {
    final int itemIndex = index ~/ 2;

    if (index.isOdd) {
      return Gap(
        1,
        crossAxisExtent: 24,
        color: context.colorTheme.outline.withValues(alpha: 0.1),
      );
    }

    return _NavigationItem(
      onNavigate: () => _onNavigate(itemIndex),
      isSelected: widget.currentIndex == itemIndex,
      item: widget.items.elementAt(itemIndex),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    super.key,
    this.isSelected = false,
    this.onNavigate,
    required this.item,
  });

  final bool isSelected;
  final VoidCallback? onNavigate;
  final NavigationItem item;

  Color _resolveLabelColor(BuildContext context) {
    final WidgetStates states = InteractiveScaleDetector.of(context).value;

    if (!states.isHovered) {
      return context.colorTheme.textSub;
    }

    return isSelected ? Colors.white : ColorThemeExtension.indigoVivid;
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveScaleDetector(
      hoverScale: isSelected ? 0.08 : 0.16,
      onTap: onNavigate,
      child: Builder(
        builder: (context) => AnimatedContainer(
          height: 40,
          width: 40,
          curve: Curves.easeOutCubic,
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: isSelected
                ? ColorThemeExtension.indigoVivid
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            item.icon,
            size: item.size,
            color: _resolveLabelColor(context),
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

class NavigationItem {
  const NavigationItem({
    this.label,
    this.size = 20,
    required this.icon,
  });

  final String? label;
  final double size;
  final IconData icon;
}
