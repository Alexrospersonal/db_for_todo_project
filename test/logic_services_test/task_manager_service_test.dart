import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:db_for_todo_project/domain/logic_services/logic_services_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../common/isar_test_service.dart';

void main() {
  group("Test Task Manager Service, testing all functions", () {
    var serviceController = IsarTestService<BaseEntityService<Isar>>();
    late TaskCreationService taskManager;
    late Isar isar;
    late int categoryId;

    setUpAll(() async {
      await serviceController.initIsar();
      isar = serviceController.db;

      taskManager = TaskCreationService(
          db: isar,
          taskService: TaskEntityService(db: isar),
          repeatedTaskService: RepeatedTaskEntityService(db: isar),
          categoryService: CategoryEntityService(db: isar));

      var newEntity = CategoryEntity(emoji: "😡", name: "test1");

      await isar.writeTxn(() async {
        categoryId = await isar.categoryEntitys.put(newEntity);
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
      var createdTask = await isar.taskEntitys.get(createdId);
      expect(createdId, createdTask!.id);
    });

    test("Test createCopyOfTask, should create the copy of task entity", () {
      var dateDto = DateTime.now();
      var newDate = dateDto.copyWith(year: 2025);

      var taskDto = createTaskDtoWithNoRepeats(
          "Test 1", "Test notate", Colors.red, dateDto);

      var copyTask = taskManager.buildSingleTaskCopy(newDate, taskDto);
      expect(copyTask.taskDate, newDate);
      expect(copyTask.title, taskDto.title);
      expect(copyTask.notate, taskDto.notate);
      expect(copyTask.color, taskDto.color);
    });

    test("TestcreateCopiesOfTask, should return some copies of task entity",
        () {
      var baseDate = DateTime(2024, 11, 01);
      List<DateTime> dayliTaskDateTime = [
        baseDate.copyWith(hour: 11, minute: 5),
        baseDate.copyWith(hour: 15, minute: 32),
        baseDate.copyWith(hour: 20, minute: 17),
      ];

      var nextDate = DateTime(2024, 11, 12);

      var taskDto = createTaskDtoWithNoRepeats(
          "Test 1", "Test notate", Colors.red, nextDate);

      var tasks = taskManager.buildDailyTaskCopies(
          dayliTaskDateTime, taskDto.taskDate!, taskDto);

      expect(tasks.length, 3);
      expect(tasks[0].taskDate, DateTime(2024, 11, 12, 11, 5));
      expect(tasks[0].title, taskDto.title);
      expect(tasks[1].taskDate, DateTime(2024, 11, 12, 15, 32));
      expect(tasks[1].title, taskDto.title);
      expect(tasks[2].taskDate, DateTime(2024, 11, 12, 20, 17));
      expect(tasks[2].title, taskDto.title);
    });

    test("Test buildTaskCopies, should create one copy of task", () {
      var nextDate = DateTime(2024, 11, 15);

      var taskDto = createTaskDtoWithNoRepeats(
          "Test 3", "Test notate", Colors.red, nextDate);

      var repeatedDto = RepeatedTaskDto(
        repeatDuringWeek: [1, 3],
      );

      var tasks = taskManager.buildTaskCopies(taskDto, repeatedDto);

      expect(tasks.length, 1);
      expect(tasks[0].taskDate!.day, 18);
    });

    test("Test buildTaskCopies, should create 3 dayli copies of task", () {
      var nextDate = DateTime(2024, 11, 15);

      var taskDto = createTaskDtoWithNoRepeats(
          "Test 3", "Test notate", Colors.red, nextDate);
      List<DateTime> dayliTaskDateTime = [
        nextDate.copyWith(hour: 11, minute: 5),
        nextDate.copyWith(hour: 15, minute: 32),
        nextDate.copyWith(hour: 20, minute: 17),
      ];

      var repeatedDto = RepeatedTaskDto(
          repeatDuringWeek: [1, 3], repeatDuringDay: dayliTaskDateTime);

      var tasks = taskManager.buildTaskCopies(taskDto, repeatedDto);

      expect(tasks.length, 3);
      expect(tasks[0].taskDate!.day, 18);
      expect(tasks[1].taskDate!.day, 18);
      expect(tasks[2].taskDate!.day, 18);

      expect(tasks[0].taskDate!.hour, 11);
      expect(tasks[1].taskDate!.hour, 15);
      expect(tasks[2].taskDate!.hour, 20);
    });

    test("Testing buildRepeatedTask, should build a task with repeats",
        () async {
      var nextDate = DateTime(2024, 11, 15);

      var taskDto = createTaskDtoWithNoRepeats(
          "Test 3", "Test notate", Colors.red, nextDate);

      var repeatedDto = RepeatedTaskDto(
        repeatDuringWeek: [1, 3],
      );

      var res =
          await taskManager.buildRepeatedTask(taskDto, repeatedDto, categoryId);

      var original = await isar.taskEntitys.get(res["original"]);
      var copy = await isar.taskEntitys.get(res["copies"][0]);

      await original!.category.load();
      await original.repeatedTask.load();

      await copy!.originalTask.load();
      await copy.category.load();
      await copy.repeatedTask.load();

      expect(original.title, copy.title);
      expect(original.id, copy.originalTask.value!.id);
      expect(original.category.value!.id, copy.category.value!.id);
      expect(original.repeatedTask.value!.id, copy.repeatedTask.value!.id);

      expect(copy.taskDate!.day, 18);
      expect(res["copies"].length, 1);
    });

    test(
        "Testing buildRepeatedTask, should build a 3 copy of task with repeats",
        () async {
      var nextDate = DateTime(2024, 11, 15);

      var taskDto = createTaskDtoWithNoRepeats(
          "Test 3", "Test notate", Colors.red, nextDate);

      List<DateTime> dayliTaskDateTime = [
        nextDate.copyWith(hour: 11, minute: 5),
        nextDate.copyWith(hour: 15, minute: 32),
        nextDate.copyWith(hour: 20, minute: 17),
      ];

      var repeatedDto = RepeatedTaskDto(
          repeatDuringWeek: [1, 3], repeatDuringDay: dayliTaskDateTime);

      var res =
          await taskManager.buildRepeatedTask(taskDto, repeatedDto, categoryId);

      var original = await isar.taskEntitys.get(res["original"]);
      var copy1 = await isar.taskEntitys.get(res["copies"][0]);
      var copy2 = await isar.taskEntitys.get(res["copies"][1]);
      var copy3 = await isar.taskEntitys.get(res["copies"][2]);

      await original!.category.load();
      await original.repeatedTask.load();

      await copy1!.originalTask.load();
      await copy1.category.load();
      await copy1.repeatedTask.load();

      await copy2!.originalTask.load();
      await copy2.category.load();
      await copy2.repeatedTask.load();

      await copy3!.originalTask.load();
      await copy3.category.load();
      await copy3.repeatedTask.load();

      expect(original.title, copy1.title);
      expect(original.id, copy1.originalTask.value!.id);
      expect(original.category.value!.id, copy1.category.value!.id);
      expect(original.repeatedTask.value!.id, copy1.repeatedTask.value!.id);

      expect(original.title, copy2.title);
      expect(original.id, copy2.originalTask.value!.id);
      expect(original.category.value!.id, copy2.category.value!.id);
      expect(original.repeatedTask.value!.id, copy2.repeatedTask.value!.id);

      expect(original.title, copy3.title);
      expect(original.id, copy3.originalTask.value!.id);
      expect(original.category.value!.id, copy3.category.value!.id);
      expect(original.repeatedTask.value!.id, copy3.repeatedTask.value!.id);

      expect(copy1.taskDate!.day, 18);
      expect(copy2.taskDate!.day, 18);
      expect(copy3.taskDate!.day, 18);

      expect(copy1.taskDate!.hour, 11);
      expect(copy2.taskDate!.hour, 15);
      expect(copy3.taskDate!.hour, 20);
      expect(res["copies"].length, 3);
    });

    test("Test buildTask, should create a simple task", () async {
      var nextDate = DateTime(2024, 11, 15);

      var taskDto = createTaskDtoWithNoRepeats(
          "Test 3", "Test notate", Colors.red, nextDate);

      var countBefore = await isar.taskEntitys.count();

      await taskManager.buildTask(taskDto, null, categoryId);

      var countAfter = await isar.taskEntitys.count();

      expect(countAfter, countBefore + 1);
    });

    test("Test buildTask, should create a task with 3 copies", () async {
      var nextDate = DateTime(2024, 11, 15);

      var taskDto = createTaskDtoWithNoRepeats(
          "Test 3", "Test notate", Colors.red, nextDate);

      List<DateTime> dayliTaskDateTime = [
        nextDate.copyWith(hour: 11, minute: 5),
        nextDate.copyWith(hour: 15, minute: 32),
        nextDate.copyWith(hour: 20, minute: 17),
      ];

      var repeatedDto = RepeatedTaskDto(
          repeatDuringWeek: [1, 3], repeatDuringDay: dayliTaskDateTime);

      var countBefore = await isar.taskEntitys.count();

      await taskManager.buildTask(taskDto, repeatedDto, categoryId);

      var countAfter = await isar.taskEntitys.count();

      expect(countAfter, countBefore + 3 + 1);
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
