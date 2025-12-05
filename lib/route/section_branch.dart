import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

@immutable
class SectionBranch extends StatefulShellBranch {
  SectionBranch._({
    required super.routes,
    super.initialLocation,
    super.preload,
  });

  factory SectionBranch({
    required String path,
    required GoRouterWidgetBuilder builder,
  }) {
    return SectionBranch._(
      preload: true,
      initialLocation: path,
      routes: [
        GoRoute(path: path, builder: builder),
      ],
    );
  }
}
