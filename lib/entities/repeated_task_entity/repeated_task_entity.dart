import 'package:isar/isar.dart';

import '../entities_exports.dart';

part 'repeated_task_entity.g.dart';

@collection
class RepeatedTaskEntity {
  Id id = Isar.autoIncrement;

  final IsarLink<TaskEntity> task = IsarLink<TaskEntity>();

  List<int>? repeatDuringWeek;

  @Index()
  DateTime? endDateOfRepeatedly;

  List<DateTime?>? repeatDuringDay;

  bool isFinished = false;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "repeatDuringWeek": repeatDuringWeek,
      "endDateOfRepeatedly": endDateOfRepeatedly,
      "repeatDuringDay": repeatDuringDay,
    };
  }
}
