import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../common/isar_test_service.dart';

void main() {
  var serviceController = IsarTestService<IFinishedTaskEntityService<Isar>>();
  late IFinishedTaskEntityService service;

  group("Test GRUD FInishedTaskEntityService", () {
    setUpAll(() async {
      await serviceController
          .initIsarAndService((db) => FinishedTaskService(db: db));
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

    test("Test, should create an finished task", () async {
      var finishedDate = DateTime.now();

      var finishedDto = FinishedTaskDto(finishedDate: finishedDate);

      var id = await service.create(finishedDto);

      var finishedTask = await serviceController.db.finishedTaskEntitys.get(id);

      expect(finishedTask!.id, id);
      expect(finishedTask.finishedDate, finishedDate);
    });

    test("Should retrieve finished task", () async {
      var finishedDate = DateTime.now();

      var archiveDto = FinishedTaskDto(finishedDate: finishedDate);

      var id = await service.create(archiveDto);

      var finishedEntity = await service.getOne(id);

      expect(finishedEntity!.id, id);
      expect(finishedEntity.finishedDate, finishedDate);
    });

    test("Should update existing", () async {
      var finishedDate = DateTime.now();

      var finishedDto = FinishedTaskDto(finishedDate: finishedDate);

      var id = await service.create(finishedDto);

      var dtoForUpdating = FinishedTaskDto(
        finishedDate: finishedDate.copyWith(hour: 10, minute: 45),
      );

      await service.update(id, dtoForUpdating);

      var finishedEntity = await service.getOne(id);

      expect(finishedEntity!.id, id);
      expect(finishedEntity.finishedDate,
          finishedDate.copyWith(hour: 10, minute: 45));
    });

    test("Should delete finished task from DB", () async {
      var finishedDate = DateTime.now();

      var finishedDto = FinishedTaskDto(finishedDate: finishedDate);

      var id = await service.create(finishedDto);
      var result = await service.delete(id);

      expect(result, true);
    });

    test("Should return false from deleting", () async {
      var result = await service.delete(999);

      expect(result, false);
    });

    test("Should get some archives", () async {
      for (var i = 0; i < 10; i++) {
        var finishedDate = DateTime.now();

        var finishedDto = FinishedTaskDto(finishedDate: finishedDate);

        await service.create(finishedDto);
      }

      var finishedTasks = await service.getAll(10, 0);
      expect(finishedTasks.length, 10);
    });
  });
}
