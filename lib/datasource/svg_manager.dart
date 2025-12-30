import 'package:vector_graphics/vector_graphics.dart';

import '../extension/let_extension.dart';

typedef SvgEntry = MapEntry<String, PictureInfo>;

class SvgManager {
  static SvgManager? _instance;

  final Map<String, PictureInfo> _svgCache;

  SvgManager._internal(this._svgCache);

  factory SvgManager() {
    if (_instance != null) {
      return _instance!;
    }

    throw Exception(
      '[SvgManager] 초기화되지 않았습니다. '
      'main()에서 SvgManager.init()을 먼저 호출해주세요.',
    );
  }

  static Future<void> init(List<String> allowPaths) async {
    _instance = await allowPaths
        .map(_loadPicture)
        .let(Future.wait)
        .then(Map.fromEntries)
        .then(SvgManager._internal);
  }

  static Future<SvgEntry> _loadPicture(String svgPath) async {
    final BytesLoader loader = AssetBytesLoader(svgPath);
    final PictureInfo value = await vg.loadPicture(loader, null);
    return MapEntry(svgPath, value);
  }

  PictureInfo? lookup(String path) {
    return _svgCache[path];
  }
}
