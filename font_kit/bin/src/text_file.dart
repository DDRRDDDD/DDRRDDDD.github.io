import 'dart:convert';
import 'dart:io';

mixin TextFileMixin {
  File? _tempFile;

  Future<File> writeTempFile(String content, {String prefix = 'subset_'}) async {
    await cleanUp();

    final Directory tempDir = await Directory.systemTemp.createTemp('font_kit_$prefix');
    final File file = File('${tempDir.path}/chars.txt');

    return _tempFile = await file.writeAsString(content, encoding: utf8);
  }

  Future<void> cleanUp() async {
    if (_tempFile == null) {
      return;
    }

    try {
      final Directory directory = _tempFile!.parent;
      final String systemTempPath = Directory.systemTemp.path;

      if (directory.path.startsWith(systemTempPath) && await directory.exists()) {
        await directory.delete(recursive: true);
      }
    }
    catch (exception) {
      stderr.writeln('임시 리소스 삭제 실패: $exception');
    }
    finally {
      _tempFile = null;
    }
  }
}