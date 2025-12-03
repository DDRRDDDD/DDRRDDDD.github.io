import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

@immutable
class SectionBranch extends StatefulShellBranch {
  SectionBranch._({
    required super.routes,
    super.initialLocation,
    // super.navigatorKey,
    // super.restorationScopeId,
    // super.observers,
  });

  factory SectionBranch({
    required String path,
    required GoRouterWidgetBuilder builder,
  }) {
    return SectionBranch._(
      initialLocation: path,
      routes: [
        GoRoute(path: path, builder: builder),
      ],
    );
  }
}
