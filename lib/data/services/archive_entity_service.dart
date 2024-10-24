import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/log_service.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:isar/isar.dart';

abstract interface class IArchiveEntityService<U> implements BaseEntityService {
  IArchiveEntityService(U db);
  Future<int> create(ArchiveDto archiveDto);
  Future<int> update(int id, ArchiveDto archiveDto);
  Future<bool> delete(int id);
  Future<ArchivedTaskEntity?> getOne(int id);
  Future<List<ArchivedTaskEntity>> getAll(int limit, int offset);
}

class ArchiveEntityService implements IArchiveEntityService<Isar> {
  final Isar db;
  const ArchiveEntityService({required this.db});

  @override
  Future<int> create(ArchiveDto archiveDto) async {
    var entity = archiveDto.toEntity();

    late int createdId;

    try {
      await db.writeTxn(() async {
        createdId = await db.archivedTaskEntitys.put(entity);
        LogService.logger.i('Archive created successfully with id: $createdId');
      });
    } catch (e, stackTrace) {
      LogService.logger
          .e('Failed to create archive: ', error: e, stackTrace: stackTrace);
      throw Exception("Error creating archive");
    }

    return createdId;
  }

  @override
  Future<bool> delete(int id) async {
    late bool result;

    try {
      await db.writeTxn(() async {
        result = await db.archivedTaskEntitys.delete(id);
      });
    } catch (e, stackTrace) {
      LogService.logger
          .e('Failed to delete archive: ', error: e, stackTrace: stackTrace);
      throw Exception("Error deleting archive");
    }
    LogService.logger.i('Archive created successfully, result: $result');
    return result;
  }

  @override
  Future<List<ArchivedTaskEntity>> getAll(int limit, int offset) async {
    try {
      var archives = await db.archivedTaskEntitys
          .where()
          .offset(offset)
          .limit(limit)
          .findAll();

      LogService.logger.i(
          "Getting archives task successful, offset: $offset, limit: $limit");

      return archives;
    } catch (e, stackTrace) {
      LogService.logger
          .e("Failed to getting archives", error: e, stackTrace: stackTrace);
      throw Exception("Error getting archives");
    }
  }

  @override
  Future<ArchivedTaskEntity?> getOne(int id) async {
    try {
      var archive = await db.archivedTaskEntitys.get(id);
      LogService.logger.i("Retrive archive succsseful with id: $id");
      return archive;
    } catch (e) {
      LogService.logger.e("Failed to getting archive", error: e);
      throw Exception("Error getting archive");
    }
  }

  @override
  Future<int> update(int id, ArchiveDto archiveDto) async {
    try {
      var archive = await db.archivedTaskEntitys.get(id);

      if (archive == null) {
        LogService.logger.e("Archive not found with id: $id");
        throw Exception("Archive not found");
      }

      late int updatedId;

      updateArchiveFields(archive, archiveDto);

      await db.writeTxn(() async {
        updatedId = await db.archivedTaskEntitys.put(archive);
      });

      LogService.logger.i("Archive updated successfully with id: $id");
      return updatedId;
    } catch (e) {
      LogService.logger.e("Failed updating archive with id: $id", error: e);
      throw Exception("Error updating archive");
    }
  }

  void updateArchiveFields(ArchivedTaskEntity archive, ArchiveDto archiveDto) {
    archive.finishedDate = archiveDto.finishedDate ?? archive.finishedDate;
    archive.isFinished = archiveDto.isFinished ?? archive.isFinished;
    archive.originalId = archiveDto.originalId ?? archive.originalId;
    archive.taskData = archiveDto.taskData ?? archive.taskData;
  }
}
