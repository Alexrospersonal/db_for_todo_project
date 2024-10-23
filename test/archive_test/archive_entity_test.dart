import 'dart:convert';

import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../common/isar_test_service.dart';

void main() {
  var serviceController = IsarTestService<BaseEntityService<Isar>>();

  group("Test Repeated task, create and to Json", () {
    late Isar db;

    setUpAll(() async {
      await serviceController.initIsar();
      db = serviceController.db;
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
    });

    test("Should create archive task", () async {
      var categoryDto = CategoryDto(name: "code", emoji: "👍");
      var taskDto = TaskDto(title: "Simple task");

      var categoryId = await CategoryEntityService(db: db).create(categoryDto);
      var taskId = await TaskEntityService(db: db).create(taskDto, categoryId);

      var task = await TaskEntityService(db: db).getOne(taskId);

      var archive = ArchivedTaskEntity(
          originalId: taskId,
          taskData: jsonEncode(task!.toJson()),
          finishedDate: DateTime.now(),
          isFinished: false);

      late int createdId;

      await db.writeTxn(() async {
        createdId = await db.archivedTaskEntitys.put(archive);
      });

      var createdArchive = await db.archivedTaskEntitys.get(createdId);

      expect(createdId, 1);
      expect(createdArchive!.originalId, taskId);
    });
  });
}
