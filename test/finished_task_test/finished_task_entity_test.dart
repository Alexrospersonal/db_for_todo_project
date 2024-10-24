import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../common/isar_test_service.dart';

void main() {
  var serviceController = IsarTestService<BaseEntityService<Isar>>();
  late Isar db;
  group("Test creating finished task entity", () {
    setUpAll(() async {
      await serviceController.initIsar();
      db = serviceController.db;
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
    });

    test("Should create finished entity", () async {
      var categoryDto = CategoryDto(name: "code", emoji: "👍");
      var taskDto = TaskDto(title: "Simple task");

      var categoryId = await CategoryEntityService(db: db).create(categoryDto);
      var taskId = await TaskEntityService(db: db).create(taskDto, categoryId);

      var task = await TaskEntityService(db: db).getOne(taskId);

      var finishedDate = DateTime.now();

      var finishedTask = FinishedTaskEntity(finishedDate: finishedDate);
      finishedTask.task.value = task;

      late int createdId;

      await db.writeTxn(() async {
        createdId = await db.finishedTaskEntitys.put(finishedTask);
        await finishedTask.task.save();
      });

      var createdEntity = await db.finishedTaskEntitys.get(createdId);
      await createdEntity!.task.load();

      expect(createdEntity.id, createdId);
      expect(createdEntity.finishedDate, finishedDate);
      expect(createdEntity.task.value!.title, "Simple task");
    });
  });
}
