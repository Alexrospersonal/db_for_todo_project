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
    var repeatDuringDayAsString = repeatDuringDay?.map((date) => date?.toIso8601String()).toList();

    return {
      "id": id,
      "repeatDuringWeek": repeatDuringWeek,
      "endDateOfRepeatedly": endDateOfRepeatedly?.toIso8601String(),
      "repeatDuringDay": repeatDuringDayAsString,
    };
  }
}
