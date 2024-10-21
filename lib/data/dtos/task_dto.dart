import 'package:db_for_todo_project/data/entities/task_entity/task_entity.dart';

// TODO: vaildate title
class TaskDto {
  String? title;
  String? notate;
  DateTime? taskDate;
  int? color;
  int? notificationId;
  bool? isCopy = false;
  bool? hasTime = false;
  bool? hasRepeats = false;
  bool? important = false;
  bool? isFinished = false;

  TaskDto({
    this.title,
    this.notate,
    this.taskDate,
    this.color,
    this.notificationId,
    this.isCopy,
    this.hasTime,
    this.hasRepeats,
    this.important,
    this.isFinished,
  }) {
    validateTitle(title);
  }

  void validateTitle(String? title) {
    if (title == null || title.isEmpty) {
      throw Exception("Title cannot be empty");
    }
  }

  TaskEntity toEntity() {
    validateTitle(title);
    var taskEntity = TaskEntity(title: title!);

    return taskEntity.copyWith(
        notate: notate,
        color: color,
        important: important,
        isFinished: isFinished,
        taskDate: taskDate,
        hasRepeats: hasRepeats,
        hasTime: hasTime,
        isCopy: isCopy,
        notificationId: notificationId);
  }

  TaskDto copyWith({
    String? title,
    String? notate,
    DateTime? taskDate,
    int? color,
    bool? isFinished,
    int? notificationId,
    bool? isCopy,
    bool? hasTime,
    bool? hasRepeats,
    bool? important,
  }) {
    var dto = TaskDto(title: title ?? this.title);

    dto.notate = notate ?? this.notate;
    dto.color = color ?? this.color;
    dto.important = important ?? this.important;
    dto.isFinished = isFinished ?? this.isFinished;

    dto.taskDate = taskDate ?? this.taskDate;
    dto.hasRepeats = hasRepeats ?? this.hasRepeats;
    dto.hasTime = hasTime ?? this.hasTime;

    dto.isCopy = isCopy ?? this.isCopy;

    dto.notificationId = notificationId ?? this.notificationId;

    return dto;
  }

  factory TaskDto.fromEntity(TaskEntity entity) {
    return TaskDto(
      title: entity.title,
      notate: entity.notate,
      color: entity.color,
      important: entity.important,
      isFinished: entity.isFinished,
      taskDate: entity.taskDate,
      hasRepeats: entity.hasRepeats,
      hasTime: entity.hasTime,
      isCopy: entity.isCopy,
      notificationId: entity.notificationId,
    );
  }
}
