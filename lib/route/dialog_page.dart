import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../extension/theme_extension.dart';

class DialogPage<T> extends Page<T> {
  const DialogPage({
    super.key,
    required this.child,
    this.barrierDismissible = true,
    this.useSafeArea = true,
  });

  final bool barrierDismissible;
  final bool useSafeArea;
  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute<T>(
      context: context,
      settings: this,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
      builder: (_) => child,
    );
  }
}

class FlowDialogPage<T> extends Page<T> {
  const FlowDialogPage({
    super.key,
    required this.children,
    this.barrierDismissible = true,
    this.useSafeArea = true,
  });

  final bool barrierDismissible;
  final bool useSafeArea;
  final List<Widget> children;

  @override
  Route<T> createRoute(BuildContext context) {
    return WoltModalSheetRoute<T>(
      settings: this,
      barrierDismissible: barrierDismissible,
      useSafeArea: useSafeArea,
      modalTypeBuilder: (context) => const ExtendedDialogType(),
      pageListBuilderNotifier: ValueNotifier(_pageListBuilder),
    );
  }

  List<SliverWoltModalSheetPage> _pageListBuilder(BuildContext context) {
    wrapWithPage(Widget child) => WoltModalSheetPage(
      backgroundColor: context.colorTheme.surfaceAlt,
      forceMaxHeight: false,
      hasTopBarLayer: false,
      child: child,
    );

    return children.map(wrapWithPage).toList();
  }
}

class ExtendedDialogType extends WoltDialogType {
  const ExtendedDialogType();

  @override
  BoxConstraints layoutModal(Size availableSize) {
    return super.layoutModal(availableSize).copyWith(
      maxHeight: max(360.0, availableSize.height * 0.9)
    );
  }
}