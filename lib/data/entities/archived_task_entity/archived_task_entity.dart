import 'package:isar/isar.dart';

part 'archived_task_entity.g.dart';

@collection
class ArchivedTaskEntity {
  Id id = Isar.autoIncrement;
  int originalId;
  String taskData;
  DateTime finishedDate;
  bool isFinished;

  ArchivedTaskEntity({
    required this.originalId,
    required this.taskData,
    required this.finishedDate,
    required this.isFinished,
  });
}
