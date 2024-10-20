import 'package:db_for_todo_project/data/entities/task_entity/task_entity.dart';

// TODO: vaildate title
class TaskDto {
  String title;
  String? notate;
  bool? important;
  int? categoryId;
  DateTime? taskDate;
  bool? hasTime;
  int? color;
  bool? hasRepeats;
  int? repeatedTaskId;
  bool? isFinished;
  bool? isCopy;
  int? originalId;
  int? notificationId;

  TaskDto({required this.title});

  factory TaskDto.fromEntity(TaskEntity entity) {
    var dto = TaskDto(title: entity.title);
    entity.category.loadSync();
    entity.originalTask.loadSync();
    entity.repeatedTask.loadSync();

    dto.notate = entity.notate;
    dto.color = entity.color;
    dto.important = entity.important;

    dto.taskDate = entity.taskDate;
    dto.hasRepeats = entity.hasRepeats;
    dto.hasTime = entity.hasTime;

    dto.isCopy = entity.isCopy;

    dto.notificationId = entity.notificationId;
    dto.categoryId = entity.category.value?.id;
    dto.originalId = entity.originalTask.value?.id;
    dto.repeatedTaskId = entity.repeatedTask.value?.id;
    return dto;
  }
}
