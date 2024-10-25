import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';

class OverdueTaskDto {
  TaskDto? task;
  DateTime? overdueDate;

  OverdueTaskDto({this.task, this.overdueDate});

  factory OverdueTaskDto.fromEntity(OverdueTaskEntity entity) {
    return OverdueTaskDto(overdueDate: entity.overdueDate);
  }

  OverdueTaskEntity toEntity() {
    if (overdueDate == null) {
      throw Exception("OverdueDate is null");
    }
    return OverdueTaskEntity(overdueDate: overdueDate!);
  }
}
