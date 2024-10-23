import 'package:isar/isar.dart';

import '../entities_exports.dart';

part 'task_entity.g.dart';

@collection
class TaskEntity {
  Id id = Isar.autoIncrement;

  String title;

  bool important = false;

  final IsarLink<CategoryEntity> category = IsarLink<CategoryEntity>();

  @Backlink(to: 'task')
  final repeatedTask = IsarLink<RepeatedTaskEntity>();

  @Backlink(to: 'task')
  final overdueTask = IsarLink<OverdueTaskEntity>();

  final IsarLink<TaskEntity> originalTask = IsarLink<TaskEntity>();

  String? notate;

  @Index()
  DateTime? taskDate;

  bool hasTime = false;

  int? color;

  bool hasRepeats = false;

  bool isFinished = false;

  bool isCopy = false;

  int? notificationId;

  TaskEntity({required this.title});

  TaskEntity copyWith(
      {String? title,
      String? notate,
      DateTime? taskDate,
      bool? hasTime,
      bool? isFinished,
      bool? hasRepeats,
      bool? important,
      bool? isCopy,
      int? color,
      int? notificationId}) {
    var task = TaskEntity(title: title ?? this.title);

    task.notate = notate ?? this.notate;
    task.taskDate = taskDate ?? this.taskDate;
    task.hasTime = hasTime ?? this.hasTime;
    task.hasRepeats = hasRepeats ?? this.hasRepeats;
    task.important = important ?? this.important;
    task.isFinished = isFinished ?? this.isFinished;
    task.color = color ?? this.color;
    task.isCopy = isCopy ?? this.isCopy;
    task.notificationId = notificationId ?? this.notificationId;

    return task;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "notate": notate,
      "taskDate": taskDate,
      "hasTime": hasTime,
      "hasRepeats": hasRepeats,
      "important": important,
      "color": color?.toInt(),
    };
  }
}
