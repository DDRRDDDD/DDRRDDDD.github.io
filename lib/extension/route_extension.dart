import 'package:go_router/go_router.dart';

import 'common_extension.dart';

extension GoRouterStateExtension on GoRouterState {
  int? queryInt(String key) {
    return uri.queryParameters[key]?.let(int.tryParse);
  }

  String? pathString(String key) {
    return pathParameters[key];
  }

  String requirePathString(String key) {
    final String? nullablePath = pathString(key);

    if (nullablePath != null) {
      return nullablePath;
    }

    throw ArgumentError('필수 경로 파라미터가 없습니다. : $key');
  }
}
