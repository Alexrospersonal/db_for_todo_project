import 'package:isar/isar.dart';

import '../entities_exports.dart';

part 'overdue_task_entity.g.dart';

@collection
class OverdueTaskEntity {
  Id id = Isar.autoIncrement;
  final IsarLink<TaskEntity> task = IsarLink<TaskEntity>();
  DateTime overdueDate;

  OverdueTaskEntity({required this.overdueDate});
}
