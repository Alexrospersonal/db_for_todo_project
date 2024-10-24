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

    // TODO: create
    test("Should create finished DTO", () {
      var finishedDate = DateTime.now();
      var dto = FinishedTaskDto(finishedDate: finishedDate);

      expect(dto.finishedDate, finishedDate);
      expect(dto.task, isNull);
    });

    test("Should return FinishedEntity", () {
      var finishedDate = DateTime.now();
      var dto = FinishedTaskDto(finishedDate: finishedDate);
      var entity = dto.toEntity();

      expect(entity.finishedDate, dto.finishedDate);
      expect(entity.task.value, dto.task);
    });

    test("Should return DTO from entity", () async {
      var finishedDate = DateTime.now();

      var entity = FinishedTaskEntity(finishedDate: finishedDate);
      var dto = FinishedTaskDto.fromEntity(entity);

      expect(entity.finishedDate, dto.finishedDate);
      expect(entity.task.value, dto.task);
    });
  });
}
