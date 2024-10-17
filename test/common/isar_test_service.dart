import 'dart:ffi';

import 'package:db_for_todo_project/services/entities_services_exports.dart';
import 'package:db_for_todo_project/services/log_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;

import 'common_test_utils.dart';

typedef EntityServiceFactory<T> = T Function(Isar db);

// If exists problems with Isar testing, reads this code:
// https://github.com/isar/isar/blob/2db8776836bb810752ff1517323ef55d57f6e554/packages/isar_test/lib/common.dart#L71
class IsarTestService<T extends BaseEntityService> {
  static const testFolder = "test";
  static const tempFolder = "temp";
  static const isarLibsFolder = "isar_libs";

  late Isar db;
  late String testTempPath;
  late T service;

  String getTestTempPath() {
    return getPathToFolder(path.join(testFolder, tempFolder));
  }

  String prepareIsarTempEnvirement() {
    TestWidgetsFlutterBinding.ensureInitialized();

    var isarLibsPath = getPathToFolder(path.join(testFolder, isarLibsFolder));

    registerBinaries(isarLibsPath);

    return testTempPath;
  }

  void registerBinaries(String isarLibsPath) {
    if (!kIsWeb) {
      try {
        Isar.initializeIsarCore(libraries: {
          // Could adding another platforms
          Abi.macosArm64: path.join(isarLibsPath, 'libisar_macos_x64.dylib'),
        });
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  Future<void> initIsarAndService(
      EntityServiceFactory createEntityService) async {
    testTempPath = getTestTempPath();
    prepareIsarTempEnvirement();

    db = await Isar.open(schemas, directory: testTempPath);
    service = createEntityService(db);
  }

  void closeIsarAndClearTempFolder() {
    try {
      db.close();
    } catch (e) {
      LogService.logger.e("Failed closing DB in test", error: e);
    }
    clearFolder(testTempPath);
  }
}
