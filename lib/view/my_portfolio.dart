import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    return widget.children.length * 2;
  }

  void _scrollToIndex(int index) {
    _controller.scrollToIndex(
      index,
      preferPosition: .begin,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      controller: _controller,
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: MainAppBarDelegate(
            onMenuTap: _scrollToIndex,
            labels: const ['About', 'Skills', 'Project', 'Contact'],
          ),
        ),
        const SliverGap(70),
        SliverList.builder(
          itemCount: _computeItemCount,
          itemBuilder: _buildSectionItem,
        ),
      ],
    );
  }

  Widget _buildSectionItem(_, int index) {
    if (index.isOdd) {
      return const Gap(120);
    }

    final int itemIndex = index ~/ 2;

    return AutoScrollTag(
      index: itemIndex,
      key: ValueKey(itemIndex),
      controller: _controller,
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: widget.children.elementAt(itemIndex),
      ),
    );
  }
}
