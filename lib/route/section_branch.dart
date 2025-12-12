import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

@immutable
class SectionBranch extends StatefulShellBranch {
  final String? menuName;

  SectionBranch._({
    super.preload,
    super.initialLocation,
    required super.routes,
    this.menuName,
  });

  factory SectionBranch({
    required String path,
    required GoRouterWidgetBuilder builder,
    String? menuName,
  }) {
    return SectionBranch._(
      preload: true,
      initialLocation: path,
      routes: [GoRoute(path: path, builder: builder)],
      menuName: menuName,
    );
  }
}
