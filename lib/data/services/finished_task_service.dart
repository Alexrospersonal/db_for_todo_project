import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/log_service.dart';
import 'package:db_for_todo_project/data/services/base_entity_service.dart';
import 'package:isar/isar.dart';

abstract interface class IFinishedTaskEntityService<U>
    implements BaseEntityService {
  IFinishedTaskEntityService(U db);
  Future<int> create(FinishedTaskDto archiveDto);
  Future<int> update(int id, FinishedTaskDto archiveDto);
  Future<bool> delete(int id);
  Future<FinishedTaskEntity?> getOne(int id);
  Future<List<FinishedTaskEntity>> getAll(int limit, int offset);
}

class FinishedTaskService implements IFinishedTaskEntityService<Isar> {
  final Isar db;
  const FinishedTaskService({required this.db});
  @override
  Future<int> create(FinishedTaskDto finishedDto) async {
    var entity = finishedDto.toEntity();

    late int createdId;

    try {
      await db.writeTxn(() async {
        createdId = await db.finishedTaskEntitys.put(entity);
        LogService.logger
            .i('Finished task created successfully with id: $createdId');
      });
    } catch (e, stackTrace) {
      LogService.logger
          .e('Failed to create finished: ', error: e, stackTrace: stackTrace);
      throw Exception("Error creating finished");
    }

    return createdId;
  }

  @override
  Future<bool> delete(int id) async {
    late bool result;

    try {
      await db.writeTxn(() async {
        result = await db.finishedTaskEntitys.delete(id);
      });
    } catch (e, stackTrace) {
      LogService.logger.e('Failed to delete finished task: ',
          error: e, stackTrace: stackTrace);
      throw Exception("Error deleting finished task");
    }
    LogService.logger.i('Finished task created successfully, result: $result');
    return result;
  }

  @override
  Future<List<FinishedTaskEntity>> getAll(int limit, int offset) async {
    try {
      var finishedTasks = await db.finishedTaskEntitys
          .where()
          .offset(offset)
          .limit(limit)
          .findAll();

      LogService.logger.i(
          "Getting finished task successful, offset: $offset, limit: $limit");

      return finishedTasks;
    } catch (e, stackTrace) {
      LogService.logger.e("Failed to getting finished tasks",
          error: e, stackTrace: stackTrace);
      throw Exception("Error getting finished tasks");
    }
  }

  @override
  Future<FinishedTaskEntity?> getOne(int id) async {
    try {
      var finished = await db.finishedTaskEntitys.get(id);
      LogService.logger.i("Retrive finished task succsseful with id: $id");
      return finished;
    } catch (e) {
      LogService.logger.e("Failed to getting finished task", error: e);
      throw Exception("Error getting finished task");
    }
  }

  @override
  Future<int> update(int id, FinishedTaskDto finishedTaskDto) async {
    try {
      var finishedTask = await db.finishedTaskEntitys.get(id);

      if (finishedTask == null) {
        LogService.logger.e("Finished task not found with id: $id");
        throw Exception("Finished task not found");
      }

      late int updatedId;

      updateFinishedTaskFields(finishedTask, finishedTaskDto);

      await db.writeTxn(() async {
        updatedId = await db.finishedTaskEntitys.put(finishedTask);
      });

      LogService.logger.i("Finished task updated successfully with id: $id");
      return updatedId;
    } catch (e) {
      LogService.logger
          .e("Failed updating Finished task with id: $id", error: e);
      throw Exception("Error updating Finished task");
    }
  }

  void updateFinishedTaskFields(
      FinishedTaskEntity finished, FinishedTaskDto dto) {
    finished.finishedDate = dto.finishedDate ?? finished.finishedDate;
  }
}
