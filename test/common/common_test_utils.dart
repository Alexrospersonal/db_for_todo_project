import 'dart:io';

import 'package:db_for_todo_project/services/log_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

String getPathToFolder(String folder) {
  final dartToolDir = path.join(Directory.current.path);
  return path.join(dartToolDir, folder);
}

Future<void> clearFolder(String path) async {
  final tempDir = Directory(path);

  if (await tempDir.exists()) {
    final contents = tempDir.listSync();

    for (var entity in contents) {
      try {
        if (entity is File) {
          await entity.delete();
        } else if (entity is Directory) {
          await entity.delete(recursive: true);
        }
      } catch (e) {
        LogService.logger.e("Error: Can't clear the folder", error: e);
      }
    }
  }
}
