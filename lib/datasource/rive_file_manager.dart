import 'package:rive/rive.dart';

class RiveFileManager {
  static RiveFileManager? _instance;

  final File myAvatarFile;
  final File developBragging;

  const RiveFileManager._internal({
    required this.myAvatarFile,
    required this.developBragging,
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
    if (!RiveNative.isInitialized) {
      await RiveNative.init();
    }

    final List<File?> files = await Future.wait([
      File.asset('assets/rive/my_avatar.riv', riveFactory: Factory.rive),
      File.asset('assets/rive/developer_bragging.riv', riveFactory: Factory.rive),
    ]);

    _instance = RiveFileManager._internal(
      myAvatarFile: files.elementAt(0)!,
      developBragging: files.elementAt(1)!,
    );
  }
}
