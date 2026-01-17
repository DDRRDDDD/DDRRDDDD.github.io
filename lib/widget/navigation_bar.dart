import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../extension/theme_extension.dart';
import '../extension/widget_states_extension.dart';
import '../theme/color_theme.dart';
import '../view/bento_grid_scaffold.dart';
import 'bento_container.dart';
import 'brightness_button.dart';
import 'glass_container.dart';
import 'scale_detector.dart';

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
    final Axis direction =
        MediaQuery.heightOf(context) <
            NavigationBarLocation.heightThreshold
        ? .vertical
        : .horizontal;

    return Flex(
      direction: direction,
      mainAxisSize: .min,
      spacing: 12,
      children: [
        GlassContainer(
          padding: const EdgeInsets.all(10),
          child: Flex(
            direction: direction,
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
    if (isSelected) {
      return Colors.white;
    }

    return ScaleDetector.of(context).value.isHovered
        ? ColorThemeExtension.indigoVivid
        : context.colorTheme.textSub;
  }

  @override
  Widget build(BuildContext context) {
    return ScaleDetector(
      hoverScale: isSelected ? 0.08 : 0.16,
      onPressUp: onNavigate,
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

class NavigationBarLocation extends StandardFabLocation {
  static const double _padding = BentoGridScaffold.verticalPadding;

  static final double _contentHeight = BentoContainer.spanHeight(3);
  static final double _contentWidth = BentoContainer.spanWidth(4);
  static final double heightThreshold = _contentHeight + 120.0;

  const NavigationBarLocation();

  @override
  double getOffsetX(ScaffoldPrelayoutGeometry geometry, _) {
    final Size screenSize = geometry.scaffoldSize;
    final double fabWidth = geometry.floatingActionButtonSize.width;

    if (screenSize.height > heightThreshold) {
      return (screenSize.width - fabWidth) / 2.0;
    }

    final double contentLeftX = (screenSize.width - _contentWidth) / 2.0;
    final double targetX = contentLeftX - fabWidth - _padding;

    return targetX.clamp(20.0, double.infinity);
  }

  @override
  double getOffsetY(ScaffoldPrelayoutGeometry geometry, _) {

    final Size screenSize = geometry.scaffoldSize;
    final double fabHeight = geometry.floatingActionButtonSize.height;

    if (screenSize.height > heightThreshold) {
      final double targetY = _contentHeight + _padding * 2;

      final double safeBottomY =
          screenSize.height - geometry.minViewPadding.bottom - 20.0 - fabHeight;

      return math.min(targetY, safeBottomY);
    }

    return (screenSize.height - fabHeight) / 2.0;
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
