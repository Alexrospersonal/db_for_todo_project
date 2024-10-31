// TODO: Service should find and build copies of repeated task
//if is nesesary after first start application on day

import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/log_service.dart';
import 'package:db_for_todo_project/domain/logic_services/logic_services_exports.dart';
import 'package:isar/isar.dart';

abstract interface class ITaskRepeatCheckerService<U> {
  final U db;
  ITaskRepeatCheckerService({required this.db});
  Future<void> generateTodayTaskCopies();
}

class TaskCopyCreationData {
  final TaskEntity task;
  final RepeatedTaskEntity repeatedTask;
  final CategoryEntity category;

  const TaskCopyCreationData(
      {required this.task, required this.repeatedTask, required this.category});
}

class TaskRepeatCheckerService implements ITaskRepeatCheckerService<Isar> {
  @override
  final Isar db;
  final TaskCreationService taskManager;
  final TaskDateManagerService dateManager = const TaskDateManagerService();

  const TaskRepeatCheckerService({required this.db, required this.taskManager});

  @override
  Future<void> generateTodayTaskCopies() async {
    var repeatedTasks = await fetchTodayRepeatingTasks();
    List<TaskCopyCreationData> repeatedTaskSaveDataList =
        await prepareTaskCopiesForToday(repeatedTasks);

    await buildCopiesOfTask(repeatedTaskSaveDataList);
  }

  Future<List<RepeatedTaskEntity>> fetchTodayRepeatingTasks() async {
    var weekday = DateTime.now().weekday;

    return await db.repeatedTaskEntitys
        .filter()
        .isFinishedEqualTo(false)
        .repeatDuringWeekElementEqualTo(weekday)
        .findAll();
  }

  Future<List<TaskCopyCreationData>> prepareTaskCopiesForToday(
      List<RepeatedTaskEntity> repeatedTasks) async {
    List<TaskCopyCreationData> repeatedTaskSaveDataList = [];
    for (var repeatedTask in repeatedTasks) {
      await repeatedTask.task.load();

      var task = repeatedTask.task.value;

      ensureTaskIsValid(task);
      var category = await getTaskCategory(task!);

      var copiestTasksForToday = await getCopiestTaskForToday(task.id);

      if (copiestTasksForToday.isEmpty) {
        var dataForSaving = TaskCopyCreationData(
            task: task, repeatedTask: repeatedTask, category: category);
        repeatedTaskSaveDataList.add(dataForSaving);
      }
    }

    return repeatedTaskSaveDataList;
  }

  void ensureTaskIsValid(TaskEntity? task) {
    isTaskNotNull(task);
    isOriginalTask(task!);
  }

  void isTaskNotNull(TaskEntity? task) {
    if (task == null) {
      LogService.logger
          .e("Failed finding and creating copy of task, task is null");
      throw Exception("Error: Task is null");
    }
  }

  void isOriginalTask(TaskEntity task) {
    if (task.originalTask.value != null) {
      LogService.logger.e("Failed finding and creating copy of task");
      throw Exception("Error: Task must be original");
    }
  }

  Future<CategoryEntity> getTaskCategory(TaskEntity task) async {
    await task.category.load();
    return task.category.value!;
  }

  Future<List<TaskEntity>> getCopiestTaskForToday(int taskId) async {
    final DateTime now = DateTime.now();
    final DateTime lower = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final DateTime upper = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return await db.taskEntitys
        .filter()
        .originalTask((q) => q.idEqualTo(taskId))
        .taskDateBetween(lower, upper)
        .findAll();
  }

  Future<void> createAndSaveTaskCopies(TaskEntity task,
      RepeatedTaskEntity repeatedTask, CategoryEntity category) async {
    var taskDto = TaskDto.fromEntity(task);
    var repeatedDto = RepeatedTaskDto.fromEntity(repeatedTask);
    var copiesTask = taskManager.buildTaskCopies(taskDto, repeatedDto);

    taskManager.addEntitiesToLinks(copiesTask, category, task, repeatedTask);

    await taskManager.taskService.saveAllInternal(copiesTask);

    await taskManager.saveCopiesLinks(copiesTask);
  }

  Future<void> markRepeatsAsCompleteIfEndingToday(
      RepeatedTaskEntity repeatedTask) async {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day, 0, 0, 0);

    if (repeatedTask.endDateOfRepeatedly != null &&
        repeatedTask.endDateOfRepeatedly == today) {
      repeatedTask.isFinished = true;
      db.repeatedTaskEntitys.put(repeatedTask);
    }
  }

  Future<void> buildCopiesOfTask(
      List<TaskCopyCreationData> repeatedTaskSaveDataList) async {
    await db.writeTxn(() async {
      for (var saveData in repeatedTaskSaveDataList) {
        await createAndSaveTaskCopies(
            saveData.task, saveData.repeatedTask, saveData.category);
        await markRepeatsAsCompleteIfEndingToday(saveData.repeatedTask);
        //TODO: дадти сповіщення
      }
    });
  }
}
