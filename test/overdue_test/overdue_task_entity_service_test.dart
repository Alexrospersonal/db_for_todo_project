import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../common/isar_test_service.dart';

void main() {
  var serviceController = IsarTestService<IOverdueTaskEntityService<Isar>>();
  late IOverdueTaskEntityService service;

  group("Test GRUD FInishedTaskEntityService", () {
    setUpAll(() async {
      await serviceController
          .initIsarAndService((db) => OverdueTaskEntityService(db: db));
      service = serviceController.service;
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
    });

    tearDown(() async {
      await serviceController.db.writeTxn(() async {
        await serviceController.db.clear();
      });
    });

    test("Test, should create an overdue task", () async {
      var overdueDate = DateTime.now();

      var finishedDto = OverdueTaskDto(overdueDate: overdueDate);

      var id = await service.create(finishedDto);

      var overdueTask = await serviceController.db.overdueTaskEntitys.get(id);

      expect(overdueTask!.id, id);
      expect(overdueTask.overdueDate, overdueDate);
    });

    test("Should retrieve overdue task", () async {
      var overdueDate = DateTime.now();

      var archiveDto = OverdueTaskDto(overdueDate: overdueDate);

      var id = await service.create(archiveDto);

      var overdueEntity = await service.getOne(id);

      expect(overdueEntity!.id, id);
      expect(overdueEntity.overdueDate, overdueDate);
    });

    test("Should update existing", () async {
      var overdueDate = DateTime.now();

      var finishedDto = OverdueTaskDto(overdueDate: overdueDate);

      var id = await service.create(finishedDto);

      var dtoForUpdating = OverdueTaskDto(
        overdueDate: overdueDate.copyWith(hour: 10, minute: 45),
      );

      await service.update(id, dtoForUpdating);

      var overdueEntity = await service.getOne(id);

      expect(overdueEntity!.id, id);
      expect(overdueEntity.overdueDate,
          overdueDate.copyWith(hour: 10, minute: 45));
    });

    test("Should delete overdue task from DB", () async {
      var overdueDate = DateTime.now();

      var overdueDto = OverdueTaskDto(overdueDate: overdueDate);

      var id = await service.create(overdueDto);
      var result = await service.delete(id);

      expect(result, true);
    });

    test("Should return false from deleting", () async {
      var result = await service.delete(999);

      expect(result, false);
    });

    test("Should get some overdue", () async {
      for (var i = 0; i < 10; i++) {
        var overdueDate = DateTime.now();

        var overdueDto = OverdueTaskDto(overdueDate: overdueDate);

        await service.create(overdueDto);
      }

      var overdueTasks = await service.getAll(10, 0);
      expect(overdueTasks.length, 10);
    });
  });
}
