import 'dart:convert';

import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/log_service.dart';
import 'package:isar/isar.dart';

abstract interface class ITaskArchivationService<U> {
  U db;
  ITaskArchivationService({required this.db});
  Future<int> archiveTasks(int timestampInDays);
}

class TaskArchivationService implements ITaskArchivationService<Isar> {
  @override
  Isar db;

  var taskIdsForDeleting = <int>[];
  var repeatedTaskIdsForDeleting = <int>[];
  var archivedTaskList = <ArchivedTaskEntity>[];

  TaskArchivationService({required this.db});

  @override
  Future<int> archiveTasks(int days) async {
    var date = DateTime.now().subtract(Duration(days: days));

    var finishedTasks = await retrieveFinishedTasks(date);
    var overdueTasks = await retrieveOverdueTasks(date);

    await buildArchiveFromFinishedTasks(finishedTasks);
    await buildArchiveFromOverdueTasks(overdueTasks);

    await saveArchivedeleteTasksFromTheirEntitys();

    return taskIdsForDeleting.length;
  }

  Future<List<FinishedTaskEntity>> retrieveFinishedTasks(DateTime date) async {
    return await db.finishedTaskEntitys.filter().finishedDateLessThan(date).findAll();
  }

  Future<List<TaskEntity>> retrieveOverdueTasks(DateTime date) async {
    return await db.taskEntitys.filter().isFinishedEqualTo(false).taskDateIsNotNull().taskDateLessThan(date).findAll();
  }

  Future<void> buildArchiveFromFinishedTasks(List<FinishedTaskEntity> finishedTasks) async {
    for (var finishedTask in finishedTasks) {
      await finishedTask.task.load();

      validateTask(finishedTask.task.value);

      await prepareDataFromEntityForArchiving(finishedTask.task.value!, finishedTask.finishedDate);
    }
  }

  Future<void> buildArchiveFromOverdueTasks(List<TaskEntity> overdueTasks) async {
    for (var task in overdueTasks) {
      await prepareDataFromEntityForArchiving(task, DateTime.now());
    }
  }

  void validateTask(TaskEntity? task) {
    if (task == null) {
      LogService.logger.e("Archivation error, task is null");
      throw Exception("Archivation error, task is null");
    }
  }

  Future<void> prepareDataFromEntityForArchiving(TaskEntity task, DateTime finishedDate) async {
    await task.category.load();
    var repeatedTask = await retrieveRepeatedTaskEntity(task);

    var archive = await buildArchiveEntity(task, repeatedTask, finishedDate);
    addIdsForDeletingToLists(task, repeatedTask);
    archivedTaskList.add(archive);
  }

  Future<RepeatedTaskEntity?> retrieveRepeatedTaskEntity(TaskEntity task) async {
    await task.repeatedTask.load();
    return task.repeatedTask.value;
  }

  Future<ArchivedTaskEntity> buildArchiveEntity(
      TaskEntity task, RepeatedTaskEntity? repeatedTask, DateTime finishedDate) async {
    var taskJsonObject = task.toJson();
    var categoryJsonObject = task.category.value?.toJson();
    var repeatedTaskJsonObject = repeatedTask?.toJson();

    taskJsonObject["category"] = categoryJsonObject;
    taskJsonObject["repeatedTask"] = repeatedTaskJsonObject;

    var archive = ArchivedTaskEntity(
        originalId: task.id,
        finishedDate: finishedDate,
        isFinished: task.isFinished,
        taskData: jsonEncode(taskJsonObject));

    return archive;
  }

  void addIdsForDeletingToLists(TaskEntity task, RepeatedTaskEntity? repeatedTask) {
    taskIdsForDeleting.add(task.id);

    if (repeatedTask != null) {
      repeatedTaskIdsForDeleting.add(repeatedTask.id);
    }
  }

  Future<void> saveArchivedeleteTasksFromTheirEntitys() async {
    try {
      await db.writeTxn(() async {
        await db.archivedTaskEntitys.putAll(archivedTaskList);
        await deleteFromEntities();
      });
    } catch (e) {
      LogService.logger.e("Failed Archivation, error: ", error: e);
      throw Exception("Failed deleting entitys");
    }
  }

  Future<void> deleteFromEntities() async {
    await db.taskEntitys.deleteAll(taskIdsForDeleting);
    await db.repeatedTaskEntitys.deleteAll(repeatedTaskIdsForDeleting);
  }
}
