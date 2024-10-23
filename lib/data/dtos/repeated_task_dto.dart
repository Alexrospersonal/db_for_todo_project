import 'package:db_for_todo_project/data/dtos/task_dto.dart';
import 'package:db_for_todo_project/data/entities/repeated_task_entity/repeated_task_entity.dart';

class RepeatedTaskDto {
  List<int>? repeatDuringWeek;
  DateTime? endDateOfRepeatedly;
  List<DateTime?>? repeatDuringDay;
  bool isFinished = false;
  TaskDto? task;

  RepeatedTaskDto(
      {this.repeatDuringWeek,
      this.repeatDuringDay,
      this.endDateOfRepeatedly,
      this.isFinished = false});

  factory RepeatedTaskDto.fromEntity(RepeatedTaskEntity repeatedEntity) {
    return RepeatedTaskDto(
      repeatDuringWeek: repeatedEntity.repeatDuringWeek,
      endDateOfRepeatedly: repeatedEntity.endDateOfRepeatedly,
      repeatDuringDay: repeatedEntity.repeatDuringDay,
      isFinished: repeatedEntity.isFinished,
    );
  }

  RepeatedTaskEntity toEntity() {
    var repeatedTaskEntity = RepeatedTaskEntity();

    repeatedTaskEntity.repeatDuringWeek = repeatDuringWeek;
    repeatedTaskEntity.endDateOfRepeatedly = endDateOfRepeatedly;
    repeatedTaskEntity.repeatDuringDay = repeatDuringDay;
    repeatedTaskEntity.isFinished = isFinished;

    return repeatedTaskEntity;
  }
}
