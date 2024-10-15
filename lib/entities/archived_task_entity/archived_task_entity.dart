import 'package:isar/isar.dart';

part 'archived_task_entity.g.dart';

@collection
class ArchivedTaskEntity {
  final Id id = Isar.autoIncrement;
  final int originalId;
  final String taskData;
  final DateTime finishedDate;
  final bool isFinished;

  const ArchivedTaskEntity({
    required this.originalId,
    required this.taskData,
    required this.finishedDate,
    required this.isFinished,
  });
}
