import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:db_for_todo_project/domain/logic_services/logic_services_exports.dart';
import 'package:isar/isar.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../common/isar_test_service.dart';

void main() {
  group("Desc", () {
    var serviceController = IsarTestService<BaseEntityService<Isar>>();
    late Isar db;
    late int categoryId;

    late TaskCreationService taskCreationService;
    late TaskRepeatCheckerService taskRepeatCheckerService;

    setUpAll(() async {
      await serviceController.initIsar();
      db = serviceController.db;

      var newEntity = CategoryEntity(emoji: "😡", name: "test1");

      await db.writeTxn(() async {
        categoryId = await db.categoryEntitys.put(newEntity);
      });

      await db.writeTxn(() async {
        var date = DateTime(2024, 10, 31, 0, 0, 0);

        var category = await db.categoryEntitys.get(categoryId);
        var task = TaskEntity(title: "Test find and create 1");
        task.taskDate = date;
        task.category.value = category;

        var repeatedTask = RepeatedTaskEntity();
        repeatedTask.repeatDuringWeek = [1, 2, 3, 4];
        repeatedTask.repeatDuringDay = [
          date.copyWith(hour: 11, minute: 5),
          date.copyWith(hour: 15, minute: 32),
          date.copyWith(hour: 20, minute: 17),
        ];
        repeatedTask.task.value = task;

        final DateTime now = DateTime.now();
        repeatedTask.endDateOfRepeatedly =
            DateTime(now.year, now.month, now.day, 0, 0, 0);

        await db.taskEntitys.put(task);
        await db.repeatedTaskEntitys.put(repeatedTask);

        await task.category.save();
        await repeatedTask.task.save();
      });

      taskCreationService = TaskCreationService(
          db: db,
          taskService: TaskEntityService(db: db),
          categoryService: CategoryEntityService(db: db),
          repeatedTaskService: RepeatedTaskEntityService(db: db));

      taskRepeatCheckerService =
          TaskRepeatCheckerService(db: db, taskManager: taskCreationService);
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
    });

    test("Test TaskRepeatChackerService find and create repeated task",
        () async {
      var countBefore = await db.taskEntitys.count();
      await taskRepeatCheckerService.generateTodayTaskCopies();
      var countAfter = await db.taskEntitys.count();
      expect(countBefore, 1);
      expect(countAfter, 4);
    });

    test("Test TaskRepeatChackerService should find nothing", () async {
      var countBefore = await db.taskEntitys.count();
      await taskRepeatCheckerService.generateTodayTaskCopies();
      var countAfter = await db.taskEntitys.count();
      expect(countBefore, 4);
      expect(countAfter, 4);
    });
  });
}
