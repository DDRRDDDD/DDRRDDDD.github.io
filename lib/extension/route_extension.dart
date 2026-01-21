import 'package:go_router/go_router.dart';

import 'common_extension.dart';

extension GoRouterStateExtension on GoRouterState {
  int? queryInt(String key) {
    return uri.queryParameters[key]?.let(int.tryParse);
  }
}