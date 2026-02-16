import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../extension/transition_extension.dart';

class SlideSheetPage<T> extends CustomTransitionPage<T> {
  const SlideSheetPage({
    super.key,
    super.opaque = false,
    super.barrierDismissible = true,
    super.barrierColor = Colors.black54,
    required super.child,
  }) : super(transitionsBuilder: _transitionsBuilder);

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    _,
    Widget child,
  ) {
    final Animation<double> alphaAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: animation.status.interval,
            reverseCurve: animation.status.reverseInterval,
          ),
        );

    final Animation<Offset> positionAnimation =
        Tween<Offset>(
          begin: context.endEdgeOffset,
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: animation.status.cubic,
            reverseCurve: animation.status.reverseCubic,
          ),
        );

    return FadeTransition(
      opacity: alphaAnimation,
      child: SlideTransition(
        position: positionAnimation,
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: SizedBox(
            width: (MediaQuery.widthOf(context) * 0.4).clamp(0, 700),
            child: Material(
              color: Colors.transparent,
              clipBehavior: Clip.hardEdge,
              borderRadius: const BorderRadiusDirectional.horizontal(
                start: Radius.circular(24),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
