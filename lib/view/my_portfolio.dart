import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../extension/theme_extension.dart';
import '../widget/primary_app_bar.dart';
import '../widget/theme_toggle.dart';

class MyPortfolioScaffold extends StatelessWidget {
  const MyPortfolioScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.background,
      appBar: const PrimaryAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: child,
        ),
      ),
      floatingActionButton: const BrightnessToggle(),
    );
  }
}

class MyPortfolioSectionContainer extends StatefulWidget {
  const MyPortfolioSectionContainer({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  final int currentIndex;
  final List<Widget> children;

  @override
  State<MyPortfolioSectionContainer> createState() {
    return _MyPortfolioSectionContainerState();
  }
}

class _MyPortfolioSectionContainerState
    extends State<MyPortfolioSectionContainer> {
  late final AutoScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AutoScrollController();
  }

  @override
  void didUpdateWidget(MyPortfolioSectionContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _controller.scrollToIndex(
        widget.currentIndex,
        preferPosition: .begin,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int get _computeItemCount {
    return widget.children.length * 2 + 1;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [

        SliverList.builder(
          itemCount: _computeItemCount,
          itemBuilder: _buildSectionItem,
        ),
      ],
    );
  }

  Widget _buildSectionItem(_, int index) {
    if (index.isEven) {
      return const SizedBox(height: 120);
    }

    final int itemIndex = index ~/ 2;

    return AutoScrollTag(
      index: itemIndex,
      key: ValueKey(itemIndex),
      controller: _controller,
      child: widget.children.elementAt(itemIndex),
    );
  }
}
