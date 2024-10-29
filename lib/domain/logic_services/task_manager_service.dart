import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/domain/logic_services/logic_services_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:db_for_todo_project/domain/utilities/common.dart';

abstract interface class ITaskManagerService<T, U> {
  Future<void> buildTask(T taskDto, U? repeatedDto, int categoryId);
}

class TaskManagerService
    implements ITaskManagerService<TaskDto, RepeatedTaskDto> {
  final ITaskEntityService taskService;
  final IRepeatedTaskEntityService repeatedTaskService;
  final ICategoryEntityService categoryService;
  final TaskDateManagerService dateManager = const TaskDateManagerService();

  const TaskManagerService(
      {required this.taskService,
      required this.categoryService,
      required this.repeatedTaskService});

  @override
  Future<void> buildTask(
      TaskDto taskDto, RepeatedTaskDto? repeatedDto, int categoryId) async {
    if (repeatedDto != null) {
      await buildRepeatedTask(taskDto, repeatedDto, categoryId);
    }
    await _buildSimpleTask(taskDto, categoryId);
  }

  Future<void> buildRepeatedTask(
      TaskDto taskDto, RepeatedTaskDto repeatedDto, int categoryId) async {
    var copiesTask = _createCopies(taskDto, repeatedDto, categoryId);

    await db.writeTxn(() async {
      var taskId = await taskService.createInternal(taskDto, categoryId);
      var repeatId =
          await repeatedTaskService.createInternal(repeatedDto, taskId);

      var task = await taskService.getOne(taskId);
      var category = await categoryService.getOne(repeatId);

      // Add category and original to copies tasks before saving
      for (var copy in copiesTask) {
        copy.category.value = category;
        copy.originalTask.value = task;
      }

      taskService.saveAllInternal(copiesTask);

      // Invoke save in category and original task for copiest tasks
      for (var copy in copiesTask) {
        await copy.category.save();
        await copy.originalTask.save();
      }
    });

    // TODO: add notifications to copies or original
    // Call NotificationService and create notification
  }

  List<TaskEntity> _createCopies(
      TaskDto taskDto, RepeatedTaskDto repeatedDto, int categoryId) {
    var weekdaysRepeat = repeatedDto.repeatDuringWeek!;
    var nextDate = dateManager.getNextDate(weekdaysRepeat, taskDto.taskDate!);

    var times = dateManager.filterNonNullTimes(repeatedDto.repeatDuringDay!);

    if (times.isNotEmpty) {
      return _getCopiesOfTask(times, nextDate, taskDto);
    }

    var date = dateManager.joinDateAndTime(nextDate, taskDto.taskDate!);
    return [_createCopyOfTask(date, taskDto)];
  }

  List<TaskEntity> _getCopiesOfTask(
      List<DateTime?> times, DateTime nextDate, TaskDto taskDto) {
    List<TaskEntity> copies = [];

    for (var time in times) {
      var newDateTime = dateManager.joinDateAndTime(nextDate, time!);
      var task = _createCopyOfTask(newDateTime, taskDto);
      copies.add(task);
    }
    return copies;
  }

  TaskEntity _createCopyOfTask(DateTime dateWithTime, TaskDto taskDto) {
    var task = taskDto.toEntity();
    var copiestTask = task.copyWith(taskDate: dateWithTime);
    copiestTask.isCopy = true;
    copiestTask.notificationId = getRandomNotificationId();
    copiestTask.hasTime = task.hasTime;

    return copiestTask;
  }

  Future<void> _buildSimpleTask(TaskDto taskDto, int categoryId) async {
    taskDto.notificationId = getRandomNotificationId();
    await taskService.create(taskDto, categoryId);
  }
}
