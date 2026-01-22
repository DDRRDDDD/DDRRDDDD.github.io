import 'package:flutter/services.dart';

import '../extension/common_extension.dart';

typedef AssetSelector = bool Function(String path);

class AssetFinder {
  static AssetFinder? _instance;

  final List<String> _listAssets;

  const AssetFinder._(this._listAssets);

  factory AssetFinder._fromManifest(AssetManifest manifest) {
    return manifest.listAssets().let(AssetFinder._);
  }

  factory AssetFinder() {
    if (_instance != null) {
      return _instance!;
    }

    throw Exception(
      '[AssetManager] 초기화되지 않았습니다. '
      'main()에서 AssetManager.init()을 먼저 호출해주세요.',
    );
  }

  static Future<void> init() async {
    if (_instance != null) {
      return;
    }

    _instance = await AssetManifest
        .loadFromAssetBundle(rootBundle)
        .then(AssetFinder._fromManifest);
  }

  List<String> get listAssets {
    return List.unmodifiable(_listAssets);
  }

  List<String> selectAssets(AssetSelector selector) {
    return listAssets.where(selector).toList();
  }
}