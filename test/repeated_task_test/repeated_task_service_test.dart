import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../common/isar_test_service.dart';

void main() {
  var serviceController = IsarTestService<IRepeatedTaskEntityService<Isar>>();
  late IRepeatedTaskEntityService service;

  group("Test CRUD RepeatedTaskService", () {
    setUpAll(() async {
      await serviceController
          .initIsarAndService((db) => RepeatedTaskEntityService(db: db));
      service = serviceController.service;
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
    });

    tearDown(() async {
      // clear DB;
    });

    test("Test create a new repeated task with task.", () async {
      int taskId =
          await createBaseTask(serviceController.db, "Work", "Simple task");

      var endDate = DateTime(2025, 02, 13);
      var createdDate = DateTime(2024, 11, 02);

      var dto = RepeatedTaskDto(
          repeatDuringWeek: [2, 4],
          endDateOfRepeatedly: endDate,
          repeatDuringDay: [
            createdDate.copyWith(hour: 14),
            createdDate.copyWith(hour: 17)
          ],
          isFinished: false);

      var task =
          await TaskEntityService(db: serviceController.db).getOne(taskId);

      var repeatedTaskId = await service.create(dto, task!);
      var repeatedTask =
          await serviceController.db.repeatedTaskEntitys.get(repeatedTaskId);

      await repeatedTask!.task.load();

      expect(repeatedTaskId, 1);
      expect(repeatedTask.endDateOfRepeatedly, endDate);

      expect(repeatedTask.repeatDuringWeek![0], 2);
      expect(repeatedTask.repeatDuringWeek![1], 4);

      expect(repeatedTask.repeatDuringDay![0], createdDate.copyWith(hour: 14));
      expect(repeatedTask.repeatDuringDay![1], createdDate.copyWith(hour: 17));

      expect(repeatedTask.task.value!.title, "Simple task");
    });
  });
}

Future<int> createBaseTask(Isar db, String category, String taskTitle) async {
  var categoryDto = CategoryDto(name: category, emoji: "🖥");
  var categoryId = await CategoryEntityService(db: db).create(categoryDto);

  var taskDate = DateTime.now();

  var dto = TaskDto(
      title: taskTitle,
      notate: "Write the best code",
      taskDate: taskDate,
      color: Colors.red.value,
      notificationId: 877766,
      isCopy: false,
      hasRepeats: true,
      hasTime: true,
      important: true,
      isFinished: false);

  return await TaskEntityService(db: db).create(dto, categoryId);
}
