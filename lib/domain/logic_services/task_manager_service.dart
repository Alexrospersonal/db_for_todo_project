import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/domain/logic_services/logic_services_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:db_for_todo_project/domain/utilities/common.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

abstract interface class ITaskManagerService<T, U> {
  Future<void> buildTask(T taskDto, U? repeatedDto, int categoryId);
}

class TaskManagerService
    implements ITaskManagerService<TaskDto, RepeatedTaskDto> {
  final Isar db;
  final ITaskEntityService taskService;
  final IRepeatedTaskEntityService repeatedTaskService;
  final ICategoryEntityService categoryService;
  final TaskDateManagerService dateManager = const TaskDateManagerService();

  const TaskManagerService(
      {required this.db,
      required this.taskService,
      required this.categoryService,
      required this.repeatedTaskService});

  @override
  Future<void> buildTask(
      TaskDto taskDto, RepeatedTaskDto? repeatedDto, int categoryId) async {
    if (repeatedDto != null) {
      await buildRepeatedTask(taskDto, repeatedDto, categoryId);
    } else {
      await buildSimpleTask(taskDto, categoryId);
    }
  }

  Future<Map<String, dynamic>> buildRepeatedTask(
      TaskDto taskDto, RepeatedTaskDto repeatedDto, int categoryId) async {
    var copiesTask = buildTaskCopies(taskDto, repeatedDto);

    late int taskId;
    late List<int> copiesIdList;

    await db.writeTxn(() async {
      taskId = await taskService.createInternal(taskDto, categoryId);
      var repeatId =
          await repeatedTaskService.createInternal(repeatedDto, taskId);

      var task = await taskService.getOne(taskId);
      var category = await categoryService.getOne(categoryId);
      var repeated = await repeatedTaskService.getOne(repeatId);

      // Add category and original to copies tasks before saving
      for (var copy in copiesTask) {
        copy.category.value = category;
        copy.originalTask.value = task;
        copy.repeatedTask.value = repeated;
      }

      copiesIdList = await taskService.saveAllInternal(copiesTask);

      // Invoke save in category and original task for copiest tasks
      for (var copy in copiesTask) {
        await copy.category.save();
        await copy.originalTask.save();
        await copy.repeatedTask.save();
      }
    });

    // TODO: add notifications to copies or original
    // Call NotificationService and create notification

    return <String, dynamic>{'original': taskId, 'copies': copiesIdList};
  }

  List<TaskEntity> buildTaskCopies(
      TaskDto taskDto, RepeatedTaskDto repeatedDto) {
    var weekdaysRepeat = repeatedDto.repeatDuringWeek!;
    var nextDate = dateManager.getNextDate(weekdaysRepeat, taskDto.taskDate!);

    var times = dateManager.filterNonNullTimes(repeatedDto.repeatDuringDay);

    if (times.isNotEmpty) {
      return buildDailyTaskCopies(times, nextDate, taskDto);
    }

    var date = dateManager.joinDateAndTime(nextDate, taskDto.taskDate!);
    return [buildSingleTaskCopy(date, taskDto)];
  }

  List<TaskEntity> buildDailyTaskCopies(
      List<DateTime?> times, DateTime nextDate, TaskDto taskDto) {
    List<TaskEntity> copies = [];

    for (var time in times) {
      var newDateTime = dateManager.joinDateAndTime(nextDate, time!);
      var task = buildSingleTaskCopy(newDateTime, taskDto);
      copies.add(task);
    }
    return copies;
  }

  TaskEntity buildSingleTaskCopy(DateTime dateWithTime, TaskDto taskDto) {
    var task = taskDto.toEntity();
    var copiestTask = task.copyWith(taskDate: dateWithTime);
    copiestTask.isCopy = true;
    copiestTask.notificationId = getRandomNotificationId();
    copiestTask.hasTime = task.hasTime;

    return copiestTask;
  }

  @visibleForTesting
  Future<int> buildSimpleTask(TaskDto taskDto, int categoryId) async {
    taskDto.notificationId = getRandomNotificationId();
    return await taskService.create(taskDto, categoryId);
  }
}
