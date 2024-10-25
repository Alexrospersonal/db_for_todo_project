import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../common/isar_test_service.dart';

void main() {
  var serviceController = IsarTestService<BaseEntityService<Isar>>();
  late Isar db;
  group("Test creating overdue task entity", () {
    setUpAll(() async {
      await serviceController.initIsar();
      db = serviceController.db;
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
    });

    test("Should create overdue task entity", () async {
      var categoryDto = CategoryDto(name: "code", emoji: "👍");
      var taskDto = TaskDto(title: "Simple task");

      var categoryId = await CategoryEntityService(db: db).create(categoryDto);
      var taskId = await TaskEntityService(db: db).create(taskDto, categoryId);

      var task = await TaskEntityService(db: db).getOne(taskId);

      var overdueDate = DateTime.now();

      var overdueTask = OverdueTaskEntity(overdueDate: overdueDate);
      overdueTask.task.value = task;

      late int createdId;

      await db.writeTxn(() async {
        createdId = await db.overdueTaskEntitys.put(overdueTask);
        await overdueTask.task.save();
      });

      var createdEntity = await db.overdueTaskEntitys.get(createdId);
      await createdEntity!.task.load();

      expect(createdEntity.id, createdId);
      expect(createdEntity.overdueDate, overdueDate);
      expect(createdEntity.task.value!.title, "Simple task");
    });
  });
}
