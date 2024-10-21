import 'dart:math';

import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'common/isar_test_service.dart';

void main() {
  var serviceController = IsarTestService<ITaskEntityService<Isar>>();
  late ITaskEntityService service;

  group("Test CRUD TaskService", () {
    setUpAll(() async {
      await serviceController
          .initIsarAndService((db) => TaskEntityService(db: db));
      service = serviceController.service;
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
    });

    tearDown(() async {
      // clear DB;
    });

    test("Test create a new task with category in the database", () async {
      var categoryDto = CategoryDto(name: "Work", emoji: "🖥");
      var categoryId = await CategoryEntityService(db: serviceController.db)
          .create(categoryDto);

      var taskDate = DateTime.now();

      var dto = TaskDto(
          title: "Write code",
          notate: "Write the best code",
          taskDate: taskDate,
          color: Colors.red.value,
          notificationId: 877766,
          isCopy: false,
          hasRepeats: true,
          hasTime: true,
          important: true,
          isFinished: false);

      var createdId = await service.create(dto, categoryId);
      expect(createdId, 1);

      var task = await serviceController.db.taskEntitys.get(createdId);
      expect(task?.title, dto.title);
      expect(task?.notate, dto.notate);
      expect(task?.taskDate, dto.taskDate);
      expect(task?.color, dto.color);
      expect(task?.notificationId, dto.notificationId);
      expect(task?.isCopy, dto.isCopy);
      expect(task?.hasRepeats, dto.hasRepeats);
      expect(task?.hasTime, dto.hasTime);
      expect(task?.important, dto.important);
      expect(task?.isFinished, dto.isFinished);
    });

    test("Test get the task with id: 1, should return task", () async {
      var task = await service.getOne(1);

      expect(task?.title, "Write code");
      expect(task?.id, 1);
    });
    test("test get a task with wrong id, should return null", () async {
      var task = await service.getOne(999);

      expect(task, isNull);
    });

    test("Test getting tasks", () async {
      await serviceController.db.writeTxn(() async {
        await serviceController.db.taskEntitys.putAll(createRandomTasksDto(10));
      });

      var list = await service.getAll(10, 0);
      expect(list.length, 10);
      expect(list[0].id, 1);
    });

    test("Should update task", () async {
      var idForUpdating = 3;

      var dto = TaskDto(
        title: "Updating value",
      );

      var updatingId = await service.update(idForUpdating, dto);
      var updatedTask = await service.getOne(updatingId);

      expect(updatedTask!.title, dto.title);
    });

    test("Should delete task with id: ", () async {
      var result = await service.delete(1);
      expect(result, true);
    });

    test("Should return false from deleting task with id: 987", () async {
      var result = await service.delete(987);
      expect(result, false);
    });
  });
}

List<TaskEntity> createRandomTasksDto(int count) {
  var list = <TaskEntity>[];

  for (var i = 0; i < count; i++) {
    var dto = TaskDto(
        title: generateRandomString(i + 1 + Random().nextInt(10) * 2),
        notate: "Write the best code",
        taskDate: DateTime.now(),
        color: Colors.red.value,
        notificationId: 877766,
        isCopy: (i % 2) == 0 ? true : false,
        hasRepeats: (i % 2) == 0 ? true : false,
        hasTime: (i % 3) == 0 ? true : false,
        important: (i % 5) == 0 ? true : false,
        isFinished: (i % 2) == 0 ? true : false);

    list.add(dto.toEntity());
  }

  return list;
}

String generateRandomString(int length) {
  const characters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
    length,
    (_) => characters.codeUnitAt(random.nextInt(characters.length)),
  ));
}
