import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:isar/isar.dart';

import '../log_service.dart';

abstract interface class IOverdueTaskEntityService<U>
    implements BaseEntityService {
  IOverdueTaskEntityService(U db);
  Future<int> create(OverdueTaskDto overdueDto);
  Future<int> update(int id, OverdueTaskDto overdueDto);
  Future<bool> delete(int id);
  Future<OverdueTaskEntity?> getOne(int id);
  Future<List<OverdueTaskEntity>> getAll(int limit, int offset);
}

class OverdueTaskEntityService implements IOverdueTaskEntityService<Isar> {
  final Isar db;
  const OverdueTaskEntityService({required this.db});

  @override
  Future<int> create(OverdueTaskDto overdueDto) async {
    var entity = overdueDto.toEntity();

    late int createdId;

    try {
      await db.writeTxn(() async {
        createdId = await db.overdueTaskEntitys.put(entity);
        LogService.logger
            .i('Overdue task created successfully with id: $createdId');
      });
    } catch (e, stackTrace) {
      LogService.logger
          .e('Failed to create overdue: ', error: e, stackTrace: stackTrace);
      throw Exception("Error creating overdue");
    }

    return createdId;
  }

  @override
  Future<bool> delete(int id) async {
    late bool result;

    try {
      await db.writeTxn(() async {
        result = await db.overdueTaskEntitys.delete(id);
      });
    } catch (e, stackTrace) {
      LogService.logger.e('Failed to delete overdue task: ',
          error: e, stackTrace: stackTrace);
      throw Exception("Error deleting overdue task");
    }
    LogService.logger.i('Overdue task created successfully, result: $result');
    return result;
  }

  @override
  Future<List<OverdueTaskEntity>> getAll(int limit, int offset) async {
    try {
      var overdueTasks = await db.overdueTaskEntitys
          .where()
          .offset(offset)
          .limit(limit)
          .findAll();

      LogService.logger
          .i("Getting overdue task successful, offset: $offset, limit: $limit");

      return overdueTasks;
    } catch (e, stackTrace) {
      LogService.logger.e("Failed to getting overdue tasks",
          error: e, stackTrace: stackTrace);
      throw Exception("Error getting overdue tasks");
    }
  }

  @override
  Future<OverdueTaskEntity?> getOne(int id) async {
    try {
      var overdue = await db.overdueTaskEntitys.get(id);
      LogService.logger.i("Retrive overdue task succsseful with id: $id");
      return overdue;
    } catch (e) {
      LogService.logger.e("Failed to getting overdue task", error: e);
      throw Exception("Error getting overdue task");
    }
  }

  @override
  Future<int> update(int id, OverdueTaskDto overdueDto) async {
    try {
      var overdueTask = await db.overdueTaskEntitys.get(id);

      if (overdueTask == null) {
        LogService.logger.e("Overdue task not found with id: $id");
        throw Exception("Overdue task not found");
      }

      late int updatedId;

      updateOverTaskFields(overdueTask, overdueDto);

      await db.writeTxn(() async {
        updatedId = await db.overdueTaskEntitys.put(overdueTask);
      });

      LogService.logger.i("Overdue task updated successfully with id: $id");
      return updatedId;
    } catch (e) {
      LogService.logger
          .e("Failed updating Overdue task with id: $id", error: e);
      throw Exception("Error updating Overdue task");
    }
  }

  void updateOverTaskFields(OverdueTaskEntity overdue, OverdueTaskDto dto) {
    overdue.overdueDate = dto.overdueDate ?? overdue.overdueDate;
  }
}
