import 'package:flutter/material.dart';

import '../extension/theme_extension.dart';

class VerticalStepper extends StatefulWidget {
  const VerticalStepper({
    super.key,
    this.controller,
    this.onStepTapped,
    this.currentIndex,
    required this.steps,
  });

  final ScrollController? controller;
  final ValueChanged<int>? onStepTapped;
  final int? currentIndex;
  final List<Step> steps;

  @override
  State<VerticalStepper> createState() => _VerticalStepperState();
}

class _VerticalStepperState extends State<VerticalStepper> {
  static const double _numberWidth = 34;
  static const double _contentMargin = 24;

  StepStyle? _stepStyle(int index) {
    return widget.steps[index].stepStyle;
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  bool _isCurrent(int index) {
    return widget.currentIndex == index;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.controller,
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
    return InkWell(
      onTap: () => widget.onStepTapped?.call(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _contentMargin,
        ),
        child: Row(
          spacing: 12,
          children: [
            Column(
              children: [
                _buildLine(!_isFirst(index)),
                _buildIcon(index),
                _buildLine(!_isLast(index)),
              ],
            ),
            Expanded(
              child: Align(
                alignment: .centerLeft,
                child: widget.steps.elementAt(index).title,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLine(bool visible) {
    return ColoredBox(
      color: Colors.black38,
      child: SizedBox(
        width: visible ? 2.0 : 0.0,
        height: _contentMargin * 2/3,
      ),
    );
  }

  Widget _buildIcon(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: _contentMargin * 1/3,
      ),
      child: SizedBox.square(
        dimension: _numberWidth,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black38,
            border: _stepStyle(index)?.border,
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: context.textTheme.heroBadge,
            ),
          ),
        ),
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
              width: !_isLast(index) ? 2.0 : 0.0,
              height: double.infinity,
              child: ColoredBox(
                color: Colors.black38,
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: kThemeAnimationDuration,
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState: _isCurrent(index)
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
          secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 60.0, // stepper 마진,
              end: _contentMargin,
              bottom: _contentMargin,
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
