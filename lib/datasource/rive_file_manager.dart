import 'package:rive/rive.dart';

///TODO TODO TODO TODO TODO TODO TODO
class RiveFileManager {
  static RiveFileManager? _instance;

  // final File myAvatarFile;
  // final File developBragging;
  final File themeToggle;

  const RiveFileManager._({
    // required this.myAvatarFile,
    // required this.developBragging,
    required this.themeToggle,
  });

  factory RiveFileManager() {
    if (_instance != null) {
      return _instance!;
    }

    throw Exception(
      '[RiveFileManager] 초기화되지 않았습니다. '
      'main()에서 RiveFileManager.init()을 먼저 호출해주세요.',
    );
  }

  static Future<void> init() async {
    if (_instance != null) {
      return;
    }

    if (!RiveNative.isInitialized) {
      await RiveNative.init();
    }

    final List<File?> files = await Future.wait([
      // File.asset('assets/rive/my_avatar.riv', riveFactory: Factory.rive),
      // File.asset('assets/rive/developer_bragging.riv', riveFactory: Factory.rive),
      File.asset('assets/rive/theme_toggle.riv', riveFactory: Factory.rive),
    ]);

    _instance = RiveFileManager._(
      // myAvatarFile: files.elementAt(0)!,
      // developBragging: files.elementAt(1)!,
      themeToggle: files.elementAt(0)!,
    );
  }
}
