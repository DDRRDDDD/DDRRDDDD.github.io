import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';
import 'beam_border.dart';

const Radius defaultRadius = Radius.circular(24);

class BentoContainer extends StatelessWidget {
  static const double bentoWidth = 240;
  static const double bentoHeight = 220;
  static const double bentoGap = 20;
  static const EdgeInsets cardPadding = EdgeInsets.all(24);
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 16,
  );
  static const BorderRadius borderRadius = BorderRadius.all(defaultRadius);

  const BentoContainer({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.color = Colors.transparent,
    this.padding,
    this.border,
    required this.child,
  });

  final double width;
  final double height;
  final Color color;
  final EdgeInsets? padding;
  final Border? border;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: padding ?? cardPadding,
        child: child,
      ),
    );
  }
}

class ProjectContainer extends StatefulWidget {
  const ProjectContainer({
    super.key,
    this.isHovered = false,
    this.beamDuration,
    this.borderColor,
    required this.child,
  });

  final bool isHovered;
  final Duration? beamDuration;
  final Color? borderColor;
  final Widget child;

  @override
  State<ProjectContainer> createState() {
    return _ProjectContainerState();
  }
}

class _ProjectContainerState extends State<ProjectContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.beamDuration ?? const Duration(seconds: 4),
      vsync: this,
    );

    if (widget.isHovered) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(ProjectContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isHovered != widget.isHovered) {
      widget.isHovered ? _controller.repeat() : _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ShapeBorder get _computeBorder {
    final BorderSide side = BorderSide(
      color: widget.borderColor ?? context.colorTheme.outline,
      width: 1.5,
    );

    return widget.isHovered
        ? BeamBorder(
            borderRadius: BentoContainer.borderRadius,
            progress: _controller.value,
            side: side,
          )
        : RoundedRectangleBorder(
            borderRadius: BentoContainer.borderRadius,
            side: side,
          );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => DecoratedBox(
        position: .foreground,
        decoration: ShapeDecoration(
          shape: _computeBorder,
        ),
        child: child,
      ),
      child: ClipRRect(
        borderRadius: BentoContainer.borderRadius,
        child: widget.child,
      ),
    );
  }
}
