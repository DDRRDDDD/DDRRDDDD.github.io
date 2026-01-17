import 'package:flutter/material.dart';

import '../extension/widget_states_extension.dart';
import 'provider.dart';

class ScaleDetector extends StatefulWidget {
  const ScaleDetector({
    super.key,
    this.onPressUp,
    this.onPressDown,
    this.onHover,
    this.enabled = true,
    this.hoverScale = 0.03,
    required this.child,
  });

  final VoidCallback? onPressUp;
  final VoidCallback? onPressDown;
  final VoidCallback? onHover;
  final bool enabled;
  final double hoverScale;
  final Widget child;

  static WidgetStatesController of(BuildContext context) {
    return Provider.of<WidgetStatesController>(context);
  }

  @override
  State<ScaleDetector> createState() {
    return _ScaleDetectorState();
  }
}

class _ScaleDetectorState extends State<ScaleDetector> {
  late final WidgetStatesController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WidgetStatesController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  MouseCursor get _cursor {
    if (!widget.enabled) {
      return SystemMouseCursors.forbidden;
    }

    if (widget.onPressUp != null || widget.onPressDown != null) {
      return SystemMouseCursors.click;
    }

    return MouseCursor.defer;
  }

  double _resolveScale(WidgetStates states) {
    final bool isClickable = widget.onPressUp != null && widget.enabled;

    if (isClickable && states.isPressed) {
      return states.isHovered ? 1.0 : 1.0 - widget.hoverScale;
    }

    if (states.isHovered) {
      return 1.0 + widget.hoverScale;
    }

    return 1.0;
  }

  void _handlePressUp() {
    if (widget.enabled) {
      widget.onPressUp?.call();
    }
  }

  void _handlePressDown() {
    if (widget.enabled) {
      widget.onPressDown?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<WidgetStatesController>(
      notifier: _controller,
      child: MouseRegion(
        cursor: _cursor,
        onEnter: (_) {
          _controller.hoverOn();
          widget.onHover?.call();
        },
        onExit: (_) {
          _controller.hoverOff();
        },
        child: GestureDetector(
          onTapUp: (_) {
            _controller.pressOff();
            _handlePressUp();
          },
          onTapCancel: () {
            _controller.pressOff();
          },
          onTapDown: (_) {
            _controller.pressOn();
            _handlePressDown();
          },
          child: ValueListenableBuilder(
            valueListenable: _controller,
            builder: _buildScalableChild,
          ),
        ),
      ),
    );
  }

  Widget _buildScalableChild(_, WidgetStates states, _) {
    return AnimatedScale(
      scale: WidgetStateProperty.resolveWith(_resolveScale).resolve(states),
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOutCubic,
      child: widget.child,
    );
  }
}
