import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../extension/theme_extension.dart';
import '../route/section_branch.dart';
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
    required this.navigationShell,
    required this.children,
  });

  final StatefulNavigationShell navigationShell;
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
    if (oldWidget.navigationShell != widget.navigationShell) {
      _scrollToIndex(widget.navigationShell.currentIndex);
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
        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: MainAppBarDelegate(
            onMenuTap: _scrollToIndex,
            labels: widget.navigationShell.route.branches
                .whereType<SectionBranch>()
                .menuNames,
          ),
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
