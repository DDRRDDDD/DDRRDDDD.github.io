import 'package:path/path.dart' as p;
import 'package:vector_graphics/vector_graphics.dart';

import '../extension/common_extension.dart';
import 'asset_finder.dart';

typedef SvgEntry = MapEntry<String, PictureInfo>;

class SkillSvgManager extends AssetFileManager<PictureInfo> {
  static const String skillAssetPath = 'assets/skill';

  static SkillSvgManager? _instance;

  const SkillSvgManager._(super.base);

  factory SkillSvgManager() {
    return _instance ?? throwUninitialized(SkillSvgManager);
  }

  static Future<void> init() async {
    _instance ??= await AssetFinder()
        .where((path) => path.startsWith(skillAssetPath))
        .map(_loadPicture)
        .let(Future.wait)
        .then(Map.fromEntries)
        .then(SkillSvgManager._);
  }

  static Future<SvgEntry> _loadPicture(String svgPath) async {
    final BytesLoader loader = AssetBytesLoader(svgPath);
    final PictureInfo value = await vg.loadPicture(loader, null);
    return MapEntry(svgPath, value);
  }

  PictureInfo pictureInfo(String key) {
    return requiredLookup(key);
  }
}

enum SkillSize {
  small(size: 44.0, suffix: 'sm'),
  medium(size: 52.0, suffix: 'md'),
  large(size: 60.0, suffix: 'lg')
  ;

  final double size;
  final String suffix;

  const SkillSize({
    required this.size,
    required this.suffix,
  });

  factory SkillSize.fromPath(String path) {
    return SkillSize.values.firstWhere(
      (size) => size.isMatch(path),
      orElse: () => SkillSize.small,
    );
  }

  bool isMatch(String path) {
    final String fileName = p.basenameWithoutExtension(path);
    return fileName.toLowerCase().endsWith(suffix);
  }
}
