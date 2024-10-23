import 'package:db_for_todo_project/data/entities/task_entity/task_entity.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../common/isar_test_service.dart';

void main() {
  var serviceController = IsarTestService<BaseEntityService<Isar>>();

  group("Test Task Entity", () {
    late Isar db;

    setUpAll(() async {
      await serviceController.initIsar();
      db = serviceController.db;
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
    });

    tearDown(() async {
      await db.writeTxn(() async {
        await serviceController.db.clear();
      });
    });

    test("Should create a base task entity with title", () async {
      var titleForTask = "Task 1";
      var task = createBaseTaskEntity(titleForTask);

      late int createdId;

      await db.writeTxn(() async {
        createdId = await serviceController.db.taskEntitys.put(task);
      });

      var createTask = await db.taskEntitys.get(createdId);

      expect(createdId, 1);
      expect(createTask, isNotNull);
      expect(createTask!.title, titleForTask);
    });

    test("Should return json object from toJson function", () async {
      var titleForTask = "Task 1";
      var task = createBaseTaskEntity(titleForTask);

      var jsonObject = await task.toJson();

      expect(jsonObject["title"], titleForTask);
    });

    test("Should create task with color, notate, date, important", () async {
      var titleForTask = "Task 1";
      var date = DateTime.now();
      var color = Colors.red.value;
      var important = true;
      var notate = "Simple notate";

      var newTask = createBaseTaskEntity(
        titleForTask,
        date: date,
      );
      newTask.color = color;
      newTask.important = important;
      newTask.taskDate = date;
      newTask.notate = notate;

      late int createdId;

      await db.writeTxn(() async {
        createdId = await db.taskEntitys.put(newTask);
      });

      var createdTask = await db.taskEntitys.get(createdId);

      expect(createdTask?.color, color);
      expect(createdTask?.taskDate, date);
      expect(createdTask?.important, important);
      expect(createdTask?.notate, notate);
    });
  });

  test("Should copy the task with the same parameters", () async {
    var titleForTask = "Task 1";
    var date = DateTime.now();
    var color = Colors.red.value;
    var important = true;
    var notate = "Simple notate";
    var task = createBaseTaskEntity(titleForTask,
        date: date, color: color, important: important, notate: notate);

    var copyOfTask = task.copyWith();

    expect(task.title, copyOfTask.title);
    expect(task.notate, copyOfTask.notate);
    expect(task.color, copyOfTask.color);
    expect(task.important, copyOfTask.important);
    expect(task.taskDate, copyOfTask.taskDate);
  });

  test("Should copy task with new date", () async {
    var taskDate = DateTime.now();
    var newDate = DateTime.now().copyWith(day: taskDate.day + 1);

    var task = createBaseTaskEntity("task 1", date: taskDate);
    var copiestTask = task.copyWith(taskDate: newDate);

    expect(task.taskDate, taskDate);
    expect(copiestTask.taskDate, newDate);
  });
}

TaskEntity createBaseTaskEntity(String title,
    {DateTime? date, int? color, bool important = false, String? notate}) {
  var baseTask = TaskEntity(title: title);
  baseTask.color = color;
  baseTask.important = important;
  baseTask.taskDate = date;
  baseTask.notate = notate;
  return baseTask;
}
