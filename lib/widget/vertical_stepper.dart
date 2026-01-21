import 'package:flutter/material.dart';

class VerticalStepper extends StatefulWidget {
  const VerticalStepper({
    super.key,
    this.onStepTapped,
    this.currentIndex,
    this.stepColor = Colors.white,
    required this.steps,
  });

  final ValueChanged<int>? onStepTapped;
  final int? currentIndex;
  final Color stepColor;
  final List<Step> steps;

  @override
  State<VerticalStepper> createState() => _VerticalStepperState();
}

class _VerticalStepperState extends State<VerticalStepper> {
  static const double _numberWidth = 10;
  static const double _contentMargin = 24;

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  bool _isCurrent(int stepIndex) {
    return widget.currentIndex == stepIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: widget.steps.length * 2,
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
      padding: const EdgeInsets.symmetric(
        horizontal: _contentMargin,
      ),
      child: Row(
        spacing: 12,
        mainAxisSize: .min,
        children: [
          Column(
            spacing: 8,
            children: [
              _buildLine(!_isFirst(index)),
              SizedBox.square(
                dimension: _numberWidth,
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
          InkWell(
            onTap: () => widget.onStepTapped?.call(index),
            child: widget.steps.elementAt(index).title,
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
        height: _contentMargin * 2 / 3,
      ),
    );
  }

  Widget _buildVerticalBody(int index) {
    return Stack(
      children: [
        PositionedDirectional(
          top: 0.0,
          bottom: 0.0,
          start: _contentMargin,
          width: _numberWidth,
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
          crossFadeState: _isCurrent(index) ? .showSecond : .showFirst,
          firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
          secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 60.0, // stepper 마진,
              end: _contentMargin,
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: widget.steps.elementAt(index).content,
            ),
          ),
        ),
      ],
    );
  }
}
