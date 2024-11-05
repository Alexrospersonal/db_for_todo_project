import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:db_for_todo_project/domain/logic_services/logic_services_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../common/isar_test_service.dart';

void main() {
  var serviceController = IsarTestService<BaseEntityService<Isar>>();
  late TaskFinishService taskFinishManager;
  late TaskCreationService taskManager;

  late Isar db;
  late int categoryId;
  late int simpleTaskId;

  group("Test finishing tasks", () {
    setUpAll(() async {
      await serviceController.initIsar();
      db = serviceController.db;

      taskManager = TaskCreationService(
          db: db,
          taskService: TaskEntityService(db: db),
          repeatedTaskService: RepeatedTaskEntityService(db: db),
          categoryService: CategoryEntityService(db: db));

      taskFinishManager = TaskFinishService(db: db);

      var newEntity = CategoryEntity(emoji: "😡", name: "test1");

      await db.writeTxn(() async {
        categoryId = await db.categoryEntitys.put(newEntity);
      });

      // Create tasks with weekday repeats
      var now = DateTime.now();
      var nextDate = DateTime(now.year, now.month, now.day);
      var endDateOfRepeatedly = DateTime(now.year, now.month, now.day, 0, 0, 0);
      var taskDto = createTaskDtoWithNoRepeats("Test 3", "Test notate", Colors.red, nextDate);

      var repeatedDto = RepeatedTaskDto(repeatDuringWeek: [1, 3], endDateOfRepeatedly: endDateOfRepeatedly);

      await taskManager.buildTask(taskDto, repeatedDto, categoryId);

      // Create simple task
      var date = DateTime(2024, 11, 1, 0, 0, 0);

      var category = await db.categoryEntitys.get(categoryId);
      var simpleTask = TaskEntity(title: "Test find and create 1");
      simpleTask.taskDate = date;
      simpleTask.category.value = category;
      simpleTask.hasRepeats = false;

      await db.writeTxn(() async {
        simpleTaskId = await db.taskEntitys.put(simpleTask);
      });

      // Cretae task with dureing repeatas
      var repeatDuringDay = [
        endDateOfRepeatedly.copyWith(hour: 11, minute: 5),
        endDateOfRepeatedly.copyWith(hour: 15, minute: 32),
        endDateOfRepeatedly.copyWith(hour: 20, minute: 17),
      ];

      var repeatedDto2 = RepeatedTaskDto(
          repeatDuringWeek: [1, 2, 3, 4, 5, 6, 7],
          endDateOfRepeatedly: endDateOfRepeatedly,
          repeatDuringDay: repeatDuringDay);

      var taskDto2 = createTaskDtoWithNoRepeats("Test 3", "Test notate", Colors.red, nextDate);

      await taskManager.buildTask(taskDto2, repeatedDto2, categoryId);
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
    });

    test("Should finishing simple task", () async {
      var res = await taskFinishManager.finishTask(simpleTaskId);
      var finishedTask = await db.taskEntitys.get(res);

      expect(res, simpleTaskId);
      expect(finishedTask!.isFinished, true);
    });

    test("Should finishing last copies of task which has repeats during week", () async {
      var res = await taskFinishManager.finishTask(simpleTaskId - 1);
      var finishedTask = await db.taskEntitys.get(res);
      await finishedTask!.originalTask.load();
      await finishedTask.repeatedTask.load();

      var originalTask = finishedTask.originalTask.value;
      var repeatedTask = finishedTask.repeatedTask.value;

      expect(res, simpleTaskId - 1);
      expect(finishedTask.isFinished, true);
      expect(originalTask!.isFinished, true);
      expect(repeatedTask!.isFinished, true);
    });

    test("Should finishing last copies of task which has repeats during day", () async {
      var res = await taskFinishManager.finishTask(simpleTaskId + 4);

      var finishedTask = await db.taskEntitys.get(res);
      await finishedTask!.originalTask.load();
      await finishedTask.repeatedTask.load();

      var originalTask = finishedTask.originalTask.value;
      var repeatedTask = finishedTask.repeatedTask.value;

      expect(res, simpleTaskId + 4);
      expect(finishedTask.isFinished, true);
      expect(originalTask!.isFinished, true);
      expect(repeatedTask!.isFinished, true);
    });
  });
}

TaskDto createTaskDtoWithNoRepeats(String title, String notate, Color color, DateTime date) {
  return TaskDto(
      title: title,
      notate: notate,
      taskDate: date,
      color: color.value,
      isCopy: false,
      hasTime: false,
      hasRepeats: false,
      important: true);
}
