import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../extension/theme_extension.dart';
import '../widget/main_app_bar.dart';
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
      extendBodyBehindAppBar: true,
      floatingActionButton: const BrightnessToggle(),
      body: child,
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
      _scrollToIndex(widget.currentIndex);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    _controller.scrollToIndex(
      index,
      preferPosition: .middle,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      controller: _controller,
      slivers: [
        const SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: MainAppBarDelegate(),
        ),
        SliverList.builder(
          itemCount: widget.children.length,
          itemBuilder: _buildSectionItem,
        ),
      ],
    );
  }

  Widget _buildSectionItem(_, int index) {
    return AutoScrollTag(
      index: index,
      key: ValueKey(index),
      controller: _controller,
      child: widget.children.elementAt(index),
    );
  }
}
