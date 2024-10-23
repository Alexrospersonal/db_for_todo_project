import 'package:db_for_todo_project/data/entities/entities_exports.dart';

class ArchiveDto {
  final int originalId;
  final String taskData;
  final DateTime finishedDate;
  final bool isFinished;

  ArchiveDto(
      {required this.originalId,
      required this.finishedDate,
      required this.isFinished,
      required this.taskData});

  factory ArchiveDto.fromEntity(ArchivedTaskEntity archive) {
    return ArchiveDto(
        originalId: archive.originalId,
        taskData: archive.taskData,
        finishedDate: archive.finishedDate,
        isFinished: archive.isFinished);
  }

  ArchivedTaskEntity toEntity() {
    return ArchivedTaskEntity(
        originalId: originalId,
        taskData: taskData,
        finishedDate: finishedDate,
        isFinished: isFinished);
  }
}
