import 'package:db_for_todo_project/data/entities/entities_exports.dart';

class ArchiveDto {
  int? originalId;
  String? taskData;
  DateTime? finishedDate;
  bool? isFinished;

  ArchiveDto(
      {this.originalId, this.finishedDate, this.isFinished, this.taskData});

  factory ArchiveDto.fromEntity(ArchivedTaskEntity archive) {
    return ArchiveDto(
        originalId: archive.originalId,
        taskData: archive.taskData,
        finishedDate: archive.finishedDate,
        isFinished: archive.isFinished);
  }

  ArchivedTaskEntity toEntity() {
    var validateRes =
        [originalId, taskData, finishedDate].any((element) => element == null);

    if (validateRes) {
      throw Exception("One of fields is null");
    }

    return ArchivedTaskEntity(
        originalId: originalId!,
        taskData: taskData!,
        finishedDate: finishedDate!,
        isFinished: isFinished ?? false);
  }
}
