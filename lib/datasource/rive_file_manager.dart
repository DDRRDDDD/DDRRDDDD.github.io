import 'dart:async';

import 'package:rive/rive.dart';

import '../extension/common_extension.dart';
import 'asset_finder.dart';

typedef RiveFileEntry = MapEntry<String, File>;

class RiveFileManager extends AssetFileManager<File> {
  static const String riveAssetPath = 'assets/rive';

  static RiveFileManager? _instance;

  const RiveFileManager._(super.base);

  factory RiveFileManager() {
    return _instance ?? throwUninitialized(RiveFileManager);
  }

  static Future<void> init() async {
    if (_instance != null) {
      return;
    }

    if (!RiveNative.isInitialized) {
      await RiveNative.init();
    }

    _instance = await AssetFinder()
        .where((path) => path.startsWith(riveAssetPath))
        .map(_loadEntry)
        .let(Future.wait)
        .then(Map.fromEntries)
        .then(RiveFileManager._);
  }

  static Future<MapEntry<String, File>> _loadEntry(String path) async {
    try {
      final File? file = await File.asset(path, riveFactory: Factory.rive);
      return MapEntry(path, file!);
    }
    catch (exception) {
      throw StateError('[$path] 로드 실패: $exception');
    }
  }

  File file(String key) {
    return requiredLookup('$riveAssetPath/$key');
  }
}
