import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:isar/isar.dart';

abstract interface class ITaskFinishService<U> {
  final U db;
  ITaskFinishService({required this.db});
  Future<int> finishTask(int taskId);
}

// TODO: add finished task to finisshed table
class TaskFinishService implements ITaskFinishService<Isar> {
  @override
  final Isar db;

  const TaskFinishService({required this.db});

  @override
  Future<int> finishTask(int taskId) async {
    bool isLastDailyRepeat = false;
    late int finishedTaskId;

    final DateTime startOfDay = getCurrentDayStartTime();

    var task = await loadTaskWithRepeats(taskId);

    var repeatedTask = task.repeatedTask.value;
    var endDateOfRepeatedly = repeatedTask?.endDateOfRepeatedly;

    if (repeatedTask?.endDateOfRepeatedly != null && endDateOfRepeatedly == startOfDay) {
      isLastDailyRepeat = checkIfLastDailyRepeat(repeatedTask!, task);
      finishedTaskId = await markAsCompletedTask(task, repeatedTask, isLastDailyRepeat);
    } else {
      finishedTaskId = await markAsCompletedSimpleTask(task);
    }
    return finishedTaskId;
  }

  DateTime getCurrentDayStartTime() {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 0, 0, 0);
  }

  Future<TaskEntity> loadTaskWithRepeats(int taskId) async {
    var task = await db.taskEntitys.get(taskId);
    await task!.repeatedTask.load();
    return task;
  }

  bool checkIfLastDailyRepeat(RepeatedTaskEntity repeatedTask, TaskEntity task) {
    var repeatedDuringDay = repeatedTask.repeatDuringDay?.where((time) => time != null).toList();

    if (repeatedDuringDay != null && repeatedDuringDay.isNotEmpty) {
      return isLastTaskTimeOnDay(task, repeatedDuringDay);
    } else {
      return true;
    }
  }

  bool isLastTaskTimeOnDay(TaskEntity task, List<DateTime?> repeatedDuringDay) {
    var now = DateTime.now();
    var lastDate = repeatedDuringDay.lastOrNull!;

    var lastTime = DateTime(now.year, now.month, now.day, lastDate.hour, lastDate.minute, lastDate.millisecond);

    if (task.taskDate == lastTime) {
      return true;
    }
    return false;
  }

  Future<int> markAsCompletedTask(TaskEntity task, RepeatedTaskEntity repeatedTask, bool isLast) async {
    late int updatedId;

    await db.writeTxn(() async {
      task.isFinished = true;
      if (isLast == true) {
        repeatedTask.isFinished = true;
        await task.originalTask.load();
        var originalTask = task.originalTask.value!;
        originalTask.isFinished = true;

        await db.repeatedTaskEntitys.put(repeatedTask);
        updatedId = (await db.taskEntitys.putAll([originalTask, task]))[1];
      } else {
        updatedId = await db.taskEntitys.put(task);
      }
      await addTaskToFinishedEntity(task);
    });

    return updatedId;
  }

  Future<int> markAsCompletedSimpleTask(TaskEntity task) async {
    late int updatedId;

    task.isFinished = true;
    await db.writeTxn(() async {
      updatedId = await db.taskEntitys.put(task);
      await addTaskToFinishedEntity(task);
    });

    return updatedId;
  }

  Future<void> addTaskToFinishedEntity(TaskEntity task) async {
    var entity = FinishedTaskEntity(finishedDate: DateTime.now());
    entity.task.value = task;
    await db.finishedTaskEntitys.put(entity);
    await entity.task.save();
  }
}
