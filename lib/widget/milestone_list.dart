import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../extension/common_extension.dart';
import '../extension/theme_extension.dart';
import '../theme/color_theme.dart';

class MilestoneList extends StatefulWidget {
  const MilestoneList({
    super.key,
    this.onToggle,
    this.currentIndex,
    this.contentMargin = 24,
    this.color = Colors.white,
    this.selectedColor = ColorThemeExtension.indigoVivid,
    required this.controller,
    required this.milestones,
  });

  final ValueChanged<int>? onToggle;
  final int? currentIndex;
  final Color color;
  final Color selectedColor;
  final double contentMargin;
  final AutoScrollController controller;
  final List<Milestone> milestones;

  @override
  State<MilestoneList> createState() => _MilestoneListState();
}

class _MilestoneListState extends State<MilestoneList> {
  static const double _dotWidth = 10;

  @override
  void initState() {
    super.initState();
    if (widget.currentIndex != null) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          _scrollToItem(widget.currentIndex!);
        }
      });
    }
  }

  @override
  void didUpdateWidget(MilestoneList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      widget.currentIndex?.let(_scrollToItem);
    }
  }

  double get _headerHeight {
    return widget.contentMargin * 2 + _dotWidth;
  }

  Future<void> _scrollToItem(int index) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await widget.controller.scrollToIndex(
        index,
        preferPosition: AutoScrollPosition.begin,
        duration: kThemeAnimationDuration,
      );
    });
  }

  void _onItemTap(int index) {
    widget.onToggle?.call(index);
    _scrollToItem(index);
  }

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: List.generate(
        widget.milestones.length * 2,
        (index) => index.isEven
            ? SliverPersistentHeader(
                pinned: widget.currentIndex == index ~/ 2,
                delegate: _MilestoneHeaderDelegate(
                  minHeight: _headerHeight,
                  maxHeight: _headerHeight,
                  child: _buildHeaderItem(index ~/ 2),
                ),
              )
            : SliverToBoxAdapter(
                child: _buildVerticalBody(index ~/ 2),
              ),
      ),
    );
  }

  Widget _buildHeaderItem(int index) {
    final bool isNotFirst = index != 0;
    final bool isNotLast = index != widget.milestones.length - 1;
    final bool isCurrent = widget.currentIndex == index;

    return AutoScrollTag(
      key: ValueKey(index),
      index: index,
      controller: widget.controller,
      child: InkWell(
        onTap: () => _onItemTap(index),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.contentMargin,
          ),
          child: Row(
            mainAxisSize: .min,
            spacing: widget.contentMargin / 2,
            children: [
              Column(
                mainAxisAlignment: .center,
                children: [
                  _buildLine(isNotFirst),
                  AnimatedContainer(
                    duration: kThemeAnimationDuration,
                    curve: Curves.fastOutSlowIn,
                    width: _dotWidth,
                    height: _dotWidth,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCurrent
                          ? widget.selectedColor
                          : widget.color,
                    ),
                  ),
                  _buildLine(isNotLast),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 1.5),
                  child: widget.milestones.elementAt(index).title,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLine(bool visible) {
    return ColoredBox(
      color: widget.color,
      child: SizedBox(
        width: visible ? 1.0 : 0.0,
        height: widget.contentMargin,
      ),
    );
  }

  Widget _buildVerticalBody(int index) {
    final bool isNotLast = index != widget.milestones.length - 1;
    final bool isCurrent = widget.currentIndex == index;

    return Stack(
      children: [
        PositionedDirectional(
          top: 0.0,
          bottom: 0.0,
          start: widget.contentMargin,
          width: _dotWidth,
          child: Center(
            child: SizedBox(
              width: isNotLast ? 1.0 : 0.0,
              height: double.infinity,
              child: ColoredBox(
                color: widget.color,
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: kThemeAnimationDuration,
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState: isCurrent
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
          firstChild: const SizedBox(width: double.infinity),
          secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
          secondChild: Padding(
            padding: EdgeInsetsDirectional.only(
              start: widget.contentMargin * 1.5 + _dotWidth,
              end: widget.contentMargin,
              bottom: widget.contentMargin,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: widget.milestones.elementAt(index).content,
            ),
          ),
        ),
      ],
    );
  }
}

class _MilestoneHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _MilestoneHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: context.colorTheme.surfaceAlt,
      child: SizedBox.expand(child: child),
    );
  }

  @override
  double get maxExtent {
    return maxHeight;
  }

  @override
  double get minExtent {
    return minHeight;
  }

  @override
  bool shouldRebuild(_MilestoneHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

abstract class Milestone {
  const Milestone();

  Widget get title;

  Widget get content;
}
