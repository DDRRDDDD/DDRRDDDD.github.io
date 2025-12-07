import 'package:rive/rive.dart';

class RiveFileManager {
  static RiveFileManager? _instance;

  final File myAvatarFile;
  final File appBarLeadingFile;

  const RiveFileManager._internal({
    required this.myAvatarFile,
    required this.appBarLeadingFile,
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
    final List<File?> files = await Future.wait([
      File.asset('assets/rive/my_avatar.riv', riveFactory: Factory.rive),
      File.asset('assets/rive/app_bar_leading.riv', riveFactory: Factory.rive),
    ]);

    _instance = RiveFileManager._internal(
      myAvatarFile: files.elementAt(0)!,
      appBarLeadingFile: files.elementAt(1)!,
    );
  }
}
