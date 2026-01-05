import 'package:flutter/material.dart';

import '../extension/widget_states_extension.dart';
import 'provider.dart';

class InteractiveScaleDetector extends StatefulWidget {
  const InteractiveScaleDetector({
    super.key,
    this.onTap,
    this.onHover,
    this.hoverScale = 0.03,
    required this.child,
  });

  final VoidCallback? onTap;
  final VoidCallback? onHover;
  final double hoverScale;
  final Widget child;

  static WidgetStatesController of(BuildContext context) {
    return Provider.of<WidgetStatesController>(context);
  }

  @override
  State<InteractiveScaleDetector> createState() {
    return _InteractiveScaleDetectorState();
  }
}

class _InteractiveScaleDetectorState extends State<InteractiveScaleDetector> {
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
    return widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer;
  }

  double _resolveScale(WidgetStates states) {
    double scale = 1.0;
    scale += states.isHovered ? widget.hoverScale : 0.0;
    scale -= states.isPressed ? widget.hoverScale : 0.0;

    return scale;
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
            widget.onTap?.call();
          },
          onTapCancel: () {
            _controller.pressOff();
          },
          onTapDown: (_) {
            _controller.pressOn();
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
