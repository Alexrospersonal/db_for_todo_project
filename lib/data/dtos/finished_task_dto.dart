import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';

class FinishedTaskDto {
  TaskDto? task;
  DateTime? finishedDate;

  FinishedTaskDto({this.task, this.finishedDate});

  factory FinishedTaskDto.fromEntity(FinishedTaskEntity entity) {
    return FinishedTaskDto(finishedDate: entity.finishedDate);
  }

  FinishedTaskEntity toEntity() {
    if (finishedDate == null) {
      throw Exception("finishedDate is null");
    }
    return FinishedTaskEntity(finishedDate: finishedDate!);
  }
}
