import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/archive_entity_service.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../common/isar_test_service.dart';

void main() {
  var serviceController = IsarTestService<IArchiveEntityService<Isar>>();
  late IArchiveEntityService service;

  group("Test CRUD ArchiveEntityService", () {
    setUpAll(() async {
      await serviceController
          .initIsarAndService((db) => ArchiveEntityService(db: db));
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

    test("Test, should create an archive task", () async {
      var archivedDate = DateTime.now();

      var archiveDto = ArchiveDto(
          finishedDate: archivedDate,
          originalId: 1,
          isFinished: false,
          taskData: "Test date");

      var id = await service.create(archiveDto);

      var archiveEntity =
          await serviceController.db.archivedTaskEntitys.get(id);

      expect(archiveEntity!.id, id);
      expect(archiveEntity.finishedDate, archivedDate);
      expect(archiveEntity.originalId, 1);
      expect(archiveEntity.isFinished, false);
      expect(archiveEntity.taskData, "Test date");
    });

    test("Should retrieve archive task", () async {
      var id = 1;

      var archivedDate = DateTime.now();

      var archiveDto = ArchiveDto(
          finishedDate: archivedDate,
          originalId: 1,
          isFinished: false,
          taskData: "Test date");

      await service.create(archiveDto);

      var archiveEntity = await service.getOne(id);

      expect(archiveEntity!.id, id);
      expect(archiveEntity.finishedDate, archivedDate);
      expect(archiveEntity.originalId, 1);
      expect(archiveEntity.isFinished, false);
      expect(archiveEntity.taskData, "Test date");
    });

    test("Should update existing", () async {
      var id = 1;

      var archivedDate = DateTime.now();

      var archiveDto = ArchiveDto(
          finishedDate: archivedDate,
          originalId: 1,
          isFinished: false,
          taskData: "Test date");

      var createdId = await service.create(archiveDto);

      var archiveDtoForUpdating = ArchiveDto(
          finishedDate: archivedDate.copyWith(hour: 10, minute: 45),
          originalId: 1,
          isFinished: false,
          taskData: "Test updated data");

      await service.update(createdId, archiveDtoForUpdating);

      var archiveEntity = await service.getOne(id);

      expect(archiveEntity!.id, id);
      expect(archiveEntity.finishedDate,
          archivedDate.copyWith(hour: 10, minute: 45));
      expect(archiveEntity.originalId, 1);
      expect(archiveEntity.isFinished, false);
      expect(archiveEntity.taskData, "Test updated data");
    });

    test("Should delete archive task from DB", () async {
      var archivedDate = DateTime.now();

      var archiveDto = ArchiveDto(
          finishedDate: archivedDate,
          originalId: 1,
          isFinished: false,
          taskData: "Test date");

      var createdId = await service.create(archiveDto);
      var result = await service.delete(createdId);

      expect(result, true);
    });

    test("Should return false from deleting", () async {
      var result = await service.delete(999);

      expect(result, false);
    });

    test("Should get some archives", () async {
      for (var i = 0; i < 10; i++) {
        var archivedDate = DateTime.now();

        var archiveDto = ArchiveDto(
            finishedDate: archivedDate,
            originalId: 1,
            isFinished: false,
            taskData: "Test date");

        await service.create(archiveDto);
      }

      var archives = await service.getAll(10, 0);
      expect(archives.length, 10);
    });
  });
}
