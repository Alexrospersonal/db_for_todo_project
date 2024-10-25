import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../common/isar_test_service.dart';

void main() {
  group("Test finished task DTO", () {
    var serviceController = IsarTestService<BaseEntityService<Isar>>();

    setUpAll(() async {
      await serviceController.initIsar();
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
    });

    test("Should create overdue DTO", () {
      var overdueDate = DateTime.now();
      var dto = OverdueTaskDto(overdueDate: overdueDate);

      expect(dto.overdueDate, overdueDate);
      expect(dto.task, isNull);
    });

    test("Should return OverdueEntity", () {
      var overdue = DateTime.now();
      var dto = OverdueTaskDto(overdueDate: overdue);
      var entity = dto.toEntity();

      expect(entity.overdueDate, dto.overdueDate);
      expect(entity.task.value, dto.task);
    });

    test("Should return DTO from entity", () async {
      var overdueDate = DateTime.now();

      var entity = OverdueTaskEntity(overdueDate: overdueDate);
      var dto = OverdueTaskDto.fromEntity(entity);

      expect(entity.overdueDate, dto.overdueDate);
      expect(entity.task.value, dto.task);
    });
  });
}
