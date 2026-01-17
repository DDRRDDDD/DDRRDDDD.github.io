import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../extension/transition_extension.dart';
import '../widget/markdown_viewer.dart';
import '../widget/property_item.dart';

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
            width: (MediaQuery.widthOf(context) * 0.45).clamp(0, 700),
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

List<Widget> buildSlivers(BuildContext context) {
  const EdgeInsets contentPadding = EdgeInsets.symmetric(horizontal: 24);

  return [
    const SliverGap(20),
    SliverPadding(
      padding: contentPadding,
      sliver: SliverList.list(
        children: [
          PropertyTitle(
            icon: Icons.smartphone,
            title: "기획서 작성하기",
          ),
          const Gap(12),
          PropertyListTile(
            icon: Icons.person_outline,
            label: "담당자",
            value: "김플러터",
          ),
          PropertyListTile(
            icon: Icons.calendar_today_outlined,
            label: "마감일",
            value: "2024년 5월 20일",
          ),
          PropertyListTile(
            icon: Icons.label_outline,
            label: "태그",
            value: "기획, 디자인",
          ),
          PropertyListTile(
            icon: Icons.check_circle_outline,
            label: "상태",
            value: "진행 중",
          ),
        ],
      ),
    ),
    SliverPadding(
      padding: contentPadding + EdgeInsets.symmetric(vertical: 12),
      sliver: SliverGap(1, color: Colors.grey[300]),
    ),
    SliverPadding(
      padding: contentPadding,
      sliver: SliverToBoxAdapter(
        child: MarkdownViewer(),
      ),
    ),
    const SliverGap(20),
  ];
}
