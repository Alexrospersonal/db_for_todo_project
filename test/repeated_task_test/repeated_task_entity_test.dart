import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:isar/isar.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

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

    test("Should create repeated task with task", () async {
      late int createId;

      var categoryDto = CategoryDto(name: "code", emoji: "👍");
      var taskDto = TaskDto(title: "Simple task");

      var categoryId = await CategoryEntityService(db: db).create(categoryDto);
      var taskId = await TaskEntityService(db: db).create(taskDto, categoryId);

      var task = await TaskEntityService(db: db).getOne(taskId);

      var createdDate = DateTime(2024, 11, 15);

      var repeatedTask = RepeatedTaskEntity();
      repeatedTask.task.value = task;
      repeatedTask.repeatDuringWeek = [1, 5];
      repeatedTask.endDateOfRepeatedly = DateTime(2024, 11, 15);

      repeatedTask.repeatDuringDay = [
        createdDate.copyWith(hour: 13, minute: 45),
        createdDate.copyWith(hour: 15, minute: 15)
      ];

      repeatedTask.isFinished = false;

      await db.writeTxn(() async {
        createId = await db.repeatedTaskEntitys.put(repeatedTask);
        repeatedTask.task.save();
      });

      var receivedRepeatedTask = await db.repeatedTaskEntitys.get(createId);
      receivedRepeatedTask?.task.load();

      expect(createId, 1);
      expect(receivedRepeatedTask!.repeatDuringWeek![0], 1);
      expect(receivedRepeatedTask.endDateOfRepeatedly, createdDate);

      var taskFromRepeat = receivedRepeatedTask.task.value;

      expect(taskFromRepeat!.title, "Simple task");
    });

    test("Should return Json object from toJson", () async {
      var repeatedTask = await db.repeatedTaskEntitys.get(1);
      var jsonObj = repeatedTask!.toJson();
      var createdDate = DateTime(2024, 11, 15);

      expect(jsonObj["id"], 1);
      expect(jsonObj["repeatDuringWeek"][0], 1);
      expect(jsonObj["repeatDuringWeek"][1], 5);
      expect(jsonObj["endDateOfRepeatedly"], createdDate);
      expect(jsonObj["repeatDuringDay"][0],
          createdDate.copyWith(hour: 13, minute: 45));
    });
  });
}
