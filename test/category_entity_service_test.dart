import 'dart:ffi';
import 'dart:io';

import 'package:db_for_todo_project/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/services/entities_services_exports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;
// import 'package:test/test.dart' as coreTest;

// TODO: виправити код
// TODO: перечитаи код: https://github.com/isar/isar/blob/2db8776836bb810752ff1517323ef55d57f6e554/packages/isar_test/lib/common.dart#L71
// TODO: написати тести

String? testTempPath;

void registerBinaries() {
  if (!kIsWeb && testTempPath == null) {
    final dartToolDir = path.join(Directory.current.path);
    testTempPath = path.join(dartToolDir, 'test', 'temp');
    var isarLibsPath = path.join(dartToolDir, 'test', 'isar_libs');
    try {
      Isar.initializeIsarCore(libraries: {
        Abi.macosArm64: path.join(isarLibsPath, 'libisar_macos_x64.dylib'),
      });
      // Isar.initializeLibraries(
      //   libraries: {
      //     'windows': path.join(dartToolDir, 'libisar_windows_x64.dll'),
      //     'macos': path.join(dartToolDir, 'libisar_macos_x64.dylib'),
      //     'linux': path.join(dartToolDir, 'libisar_linux_x64.so'),
      //   },
      // );
    } catch (e) {
      // ignore. maybe this is an instrumentation test
    }
  }
}

// Future<Isar> openTempIsar({required String name}) async {
//   registerBinaries();

//   return Isar.open(
//     schemas,
//     name: name,
//     directory: kIsWeb ? '' : testTempPath!,
//   );
// }

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
        print('Не вдалося видалити $entity: $e');
      }
    }
  }
}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  registerBinaries();

  late Isar db;
  late CategoryEntityService categoryEntityService;

  final dartToolDir = path.join(Directory.current.path);
  testTempPath = path.join(dartToolDir, 'test', 'temp');

  // db = await Isar.open(schemas, directory: testTempPath!);
  // categoryEntityService = CategoryEntityService(db: db);

  setUp(() async {
    db = await Isar.open(schemas, directory: testTempPath!);
    categoryEntityService = CategoryEntityService(db: db);
  });

  tearDownAll(() async {
    db.close();
    clearFolder(testTempPath!);
    // await Directory(testTempPath!).delete(recursive: true);
  });

  test("Should create a new category in the database with id 1 and name",
      () async {
    var categoryDto = CategoryDto(emoji: "😡", name: "test");

    final createdId = await categoryEntityService.create(categoryDto);
    final category = await categoryEntityService.getOne(createdId);

    expect(createdId, 1);
    expect(categoryDto.name, category!.name);
  });
}
