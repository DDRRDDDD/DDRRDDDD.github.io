import 'package:collection/collection.dart';
import 'package:flutter/services.dart';

import '../extension/common_extension.dart';

typedef AssetSelector = bool Function(String path);

Never throwUninitialized(Type type) {
  throw StateError('[$type]가 초기화되지 않았습니다.');
}

class AssetFinder extends DelegatingList<String>
    with NonGrowableListMixin<String> {

  static AssetFinder? _instance;

  const AssetFinder._(super.base);

  factory AssetFinder._fromManifest(AssetManifest manifest) {
    return manifest.listAssets().let(AssetFinder._);
  }

  factory AssetFinder() {
    return _instance ?? throwUninitialized(AssetFinder);
  }

  static Future<void> init() async {
    if (_instance != null) {
      return;
    }

    _instance = await AssetManifest
        .loadFromAssetBundle(rootBundle)
        .then(AssetFinder._fromManifest);
  }
}


abstract class AssetFileManager<V> extends DelegatingMap<String, V>
    with UnmodifiableMapMixin<String, V> {
  const AssetFileManager(super.base);
}