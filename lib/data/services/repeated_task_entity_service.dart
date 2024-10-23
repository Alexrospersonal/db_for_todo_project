import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/log_service.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:isar/isar.dart';

abstract interface class IRepeatedTaskEntityService<U>
    implements BaseEntityService {
  IRepeatedTaskEntityService(U db);
  Future<int> create(RepeatedTaskDto dto, TaskEntity task);
  Future<int> update(int id, RepeatedTaskDto dto);
  Future<bool> delete(int id);
  Future<RepeatedTaskEntity?> getOne(int id);
  Future<List<RepeatedTaskEntity>> getAll(int limit, int offset);
}

class RepeatedTaskEntityService implements IRepeatedTaskEntityService<Isar> {
  final Isar db;

  RepeatedTaskEntityService({required this.db});

  @override
  Future<int> create(RepeatedTaskDto dto, TaskEntity task) async {
    var repeatedTaskEntity = dto.toEntity();
    repeatedTaskEntity.task.value = task;

    late int createdId;

    try {
      await db.writeTxn(() async {
        createdId = await db.repeatedTaskEntitys.put(repeatedTaskEntity);
        await repeatedTaskEntity.task.save();
      });
    } catch (e, stackTrace) {
      LogService.logger.e("Failed to create repeated task",
          error: e, stackTrace: stackTrace);
      throw Exception("Error creating task");
    }

    LogService.logger
        .i("Repeated task created successfully with id: $createdId");
    return createdId;
  }

  @override
  Future<bool> delete(int id) async {
    late bool result;

    try {
      await db.writeTxn(() async {
        result = await db.repeatedTaskEntitys.delete(id);
      });
    } catch (e, stackTrace) {
      LogService.logger.e("Failed to delete repeated task with id: $id",
          error: e, stackTrace: stackTrace);
      throw Exception("Error deleting repeated task");
    }

    LogService.logger.i("Repeated task deleted successfully with id: $id");
    return result;
  }

  @override
  Future<List<RepeatedTaskEntity>> getAll(int limit, int offset) async {
    try {
      var repeatedTasks = await db.repeatedTaskEntitys
          .where()
          .offset(offset)
          .limit(limit)
          .findAll();

      LogService.logger.i(
          "Getting repeated tasks successful, offset: $offset, limit: $limit");

      return repeatedTasks;
    } catch (e, stackTrace) {
      LogService.logger.e("Failed to getting repeated tasks",
          error: e, stackTrace: stackTrace);
      throw Exception("Error getting repeated tasks");
    }
  }

  @override
  Future<RepeatedTaskEntity?> getOne(int id) async {
    try {
      var repeatedTask = await db.repeatedTaskEntitys.get(id);
      LogService.logger.i("Retrive repeated task succsseful with id: $id");
      return repeatedTask;
    } catch (e, stackTrace) {
      LogService.logger.e("Failed to getting repeated task with id: $id",
          error: e, stackTrace: stackTrace);
      throw Exception("Error getting task");
    }
  }

  @override
  Future<int> update(int id, RepeatedTaskDto dto) async {
    late int updatedId;

    try {
      var repeatedTask = await db.repeatedTaskEntitys.get(id);

      if (repeatedTask == null) {
        LogService.logger.e("Repeated task not found with id: $id");
        throw Exception("Repeated task not found");
      }

      updateRepeatTaskFields(repeatedTask, dto);

      await db.writeTxn(() async {
        updatedId = await db.repeatedTaskEntitys.put(repeatedTask);
      });
    } catch (e, stackTrace) {
      LogService.logger.e("Failed updating repeated task with id: $id",
          error: e, stackTrace: stackTrace);
      throw Exception("Error updating task");
    }
    LogService.logger.i("Repeated task updated successfully with id: $id");
    return updatedId;
  }

  void updateRepeatTaskFields(
      RepeatedTaskEntity repeatedTask, RepeatedTaskDto dto) {
    repeatedTask.isFinished = dto.isFinished;
    repeatedTask.repeatDuringWeek =
        dto.repeatDuringWeek ?? repeatedTask.repeatDuringWeek;
    repeatedTask.endDateOfRepeatedly =
        dto.endDateOfRepeatedly ?? repeatedTask.endDateOfRepeatedly;
    repeatedTask.repeatDuringDay =
        dto.repeatDuringDay ?? repeatedTask.repeatDuringDay;
  }
}
