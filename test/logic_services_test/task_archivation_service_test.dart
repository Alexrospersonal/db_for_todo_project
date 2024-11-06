import 'dart:convert';

import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:db_for_todo_project/domain/logic_services/logic_services_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../common/isar_test_service.dart';

void main() {
  group("Desc", () {
    var serviceController = IsarTestService<BaseEntityService<Isar>>();
    late Isar db;
    late int categoryId;
    late int finishedTaskId;
    late TaskArchivationService archiveService;

    setUpAll(() async {
      await serviceController.initIsar();
      db = serviceController.db;

      var newEntity = CategoryEntity(emoji: "😡", name: "test1");

      await db.writeTxn(() async {
        categoryId = await db.categoryEntitys.put(newEntity);
      });

      archiveService = TaskArchivationService(db: db);

      var date = DateTime(2024, 09, 6, 0, 0, 0);
      var category = await db.categoryEntitys.get(categoryId);

      var task = TaskEntity(title: "Finished Task");
      task.taskDate = date;
      task.category.value = category;

      var repeatedTask = RepeatedTaskEntity();
      repeatedTask.repeatDuringWeek = [1, 2, 3, 4, 5, 6, 7];
      repeatedTask.repeatDuringDay = [
        date.copyWith(hour: 11, minute: 5),
        date.copyWith(hour: 15, minute: 32),
        date.copyWith(hour: 20, minute: 17),
      ];
      repeatedTask.task.value = task;

      var task2 = TaskEntity(title: "Overdue Task");
      task2.taskDate = date;

      await db.writeTxn(() async {
        finishedTaskId = await db.taskEntitys.put(task);
        await db.taskEntitys.put(task2);
        await db.repeatedTaskEntitys.put(repeatedTask);

        await task.category.save();
        await repeatedTask.task.save();
      });

      var finishService = TaskFinishService(db: db);
      await finishService.finishTask(finishedTaskId);
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
    });

    test("Should archive one finished task", () async {
      var task = await db.taskEntitys.get(finishedTaskId);
      await task!.category.load();
      await task.repeatedTask.load();

      var repeatedTask = task.repeatedTask.value;

      var taskJsonObject = task.toJson();
      var categoryJsonObject = task.category.value?.toJson();
      var repeatedTaskJsonObject = repeatedTask?.toJson();

      taskJsonObject["category"] = categoryJsonObject;
      taskJsonObject["repeatedTask"] = repeatedTaskJsonObject;

      var jsonString = jsonEncode(taskJsonObject);

      var res = await archiveService.archiveTasks(0);
      var tasks = await db.taskEntitys.count();
      var repeatedTasksCount = await db.repeatedTaskEntitys.count();
      var finishedTasksCount = await db.finishedTaskEntitys.count();

      var archive = await db.archivedTaskEntitys.get(1);

      expect(res, 2);
      expect(tasks, 0);
      expect(repeatedTasksCount, 0);
      expect(finishedTasksCount, 0);
      expect(archive, isNotNull);
      expect(archive!.taskData, jsonString);
    });
  });
}
