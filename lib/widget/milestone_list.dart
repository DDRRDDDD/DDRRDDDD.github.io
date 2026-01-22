import 'package:flutter/material.dart';

class MilestoneList extends StatefulWidget {
  const MilestoneList({
    super.key,
    this.onStepTapped,
    this.currentIndex,
    this.stepColor = Colors.white,
    this.contentMargin = 24,
    required this.milestones,
  });

  final ValueChanged<int>? onStepTapped;
  final int? currentIndex;
  final Color stepColor;
  final double contentMargin;
  final List<Milestone> milestones;

  @override
  State<MilestoneList> createState() => _MilestoneListState();
}

class _MilestoneListState extends State<MilestoneList> {
  static const double _dotWidth = 10;

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.milestones.length - 1 == index;
  }

  CrossFadeState _currentFadeState(int stepIndex) {
    return widget.currentIndex == stepIndex ? .showSecond : .showFirst;
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: widget.milestones.length * 2,
      itemBuilder: (_, index) {
        final int itemIndex = index ~/ 2;
        return index.isEven
            ? _buildVerticalHeader(itemIndex)
            : _buildVerticalBody(itemIndex);
      },
    );
  }

  Widget _buildVerticalHeader(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.contentMargin,
      ),
      child: Row(
        mainAxisSize: .min,
        spacing: widget.contentMargin / 2,
        children: [
          Column(
            spacing: 8,
            children: [
              _buildLine(!_isFirst(index)),
              SizedBox.square(
                dimension: _dotWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.stepColor,
                  ),
                ),
              ),
              _buildLine(!_isLast(index)),
            ],
          ),
          Expanded(
            child: InkWell(
              onTap: () => widget.onStepTapped?.call(index),
              child: widget.milestones.elementAt(index).title,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine(bool visible) {
    return ColoredBox(
      color: widget.stepColor,
      child: SizedBox(
        width: visible ? 1.0 : 0.0,
        height: widget.contentMargin * 2 / 3,
      ),
    );
  }

  Widget _buildVerticalBody(int index) {
    return Stack(
      children: [
        PositionedDirectional(
          top: 0.0,
          bottom: 0.0,
          start: widget.contentMargin,
          width: _dotWidth,
          child: Center(
            child: SizedBox(
              width: !_isLast(index) ? 1.0 : 0.0,
              height: double.infinity,
              child: ColoredBox(
                color: widget.stepColor,
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: kThemeAnimationDuration,
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState: _currentFadeState(index),
          firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
          firstChild: const SizedBox(width: double.infinity),
          secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
          secondChild: Padding(
            padding: EdgeInsetsDirectional.only(
              start: widget.contentMargin * 1.5 + _dotWidth,
              end: widget.contentMargin,
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

abstract class Milestone {
  const Milestone();

  Widget get title;
  Widget get content;
}