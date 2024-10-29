import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:db_for_todo_project/domain/logic_services/logic_services_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../archive_test/archive_entity_service_test.dart';
import '../common/isar_test_service.dart';

void main() {
  group("Test Task Manager Service, testing all functions", () {
    var serviceController = IsarTestService<BaseEntityService<Isar>>();
    late TaskManagerService taskManager;
    late Isar db;
    late int categoryId;

    setUpAll(() async {
      await serviceController.initIsar();
      db = serviceController.db;

      taskManager = TaskManagerService(
          taskService: TaskEntityService(db: db),
          repeatedTaskService: RepeatedTaskEntityService(db: db),
          categoryService: CategoryEntityService(db: db));

      var newEntity = CategoryEntity(emoji: "😡", name: "test1");

      await db.writeTxn(() async {
        categoryId = await db.categoryEntitys.put(newEntity);
      });
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
    });

    test("Test buildSimpleTask, should create a task entity", () async {
      var date = DateTime.now();

      var taskDto = TaskDto(
          title: "Test 1",
          notate: "Test notate",
          taskDate: date,
          color: Colors.red.value,
          isCopy: false,
          hasTime: false,
          hasRepeats: false,
          important: true);

      var createdId = await taskManager.buildSimpleTask(taskDto, categoryId);
      var createdTask = await db.taskEntitys.get(createdId);
      expect(createdId, createdTask!.id);
    });

    test("Test createCopyOfTask, should create the copy of task entity", () {
      var dateDto = DateTime.now();
      var newDate = dateDto.copyWith(year: 2025);

      var taskDto = createTaskDtoWithNoRepeats(
          "Test 1", "Test notate", Colors.red, dateDto);

      var copyTask = taskManager.createCopyOfTask(newDate, taskDto);
      expect(copyTask.taskDate, newDate);
      expect(copyTask.title, taskDto.title);
      expect(copyTask.notate, taskDto.notate);
      expect(copyTask.color, taskDto.color);
    });
  });
}

TaskDto createTaskDtoWithNoRepeats(
    String title, String notate, Color color, DateTime date) {
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
