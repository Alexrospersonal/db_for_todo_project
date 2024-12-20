import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/log_service.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:isar/isar.dart';

abstract interface class ITaskEntityService<U> implements BaseEntityService {
  ITaskEntityService(U db);
  Future<int> create(TaskDto dto, int categoryId);
  Future<int> createInternal(TaskDto dto, int categoryId);
  Future<List<int>> saveAll(List<TaskEntity> tasks);
  Future<List<int>> saveAllInternal(List<TaskEntity> tasks);
  Future<int> update(int id, TaskDto dto, [int? newCategoryId]);
  Future<bool> delete(int id);
  Future<TaskEntity?> getOne(int id);
  Future<List<TaskEntity>> getAll(int limit, int offset);
}

/// Internal methods should using only in transaction
class TaskEntityService implements ITaskEntityService<Isar> {
  late CategoryEntityService categoryService;
  final Isar db;

  TaskEntityService({required this.db})
      : categoryService = CategoryEntityService(db: db);

  @override
  Future<int> create(TaskDto dto, int categoryId) async {
    late int createdId;

    try {
      await db.writeTxn(() async {
        createdId = await createInternal(dto, categoryId);
      });
    } catch (e) {
      LogService.logger.e("Failed to create task", error: e);
      throw Exception("Error creating task");
    }
    LogService.logger.i("Task created successfully with id: $createdId");

    return createdId;
  }

  @override
  Future<int> createInternal(TaskDto dto, int categoryId) async {
    var task = dto.toEntity();

    var category = await categoryService.getOne(categoryId);

    if (category == null) {
      LogService.logger.e("Failed to create task, category not found");
      throw Exception("Error creating task");
    }

    task.category.value = category;
    var createdId = await db.taskEntitys.put(task);
    await task.category.save();
    return createdId;
  }

  @override
  Future<bool> delete(int id) async {
    late bool result;

    try {
      await db.writeTxn(() async {
        result = await db.taskEntitys.delete(id);
      });
    } catch (e) {
      LogService.logger.e("Failed to delete task with id: $id", error: e);
      throw Exception("Error deleting task");
    }

    LogService.logger.i("Task deleted successfully with id: $id");
    return result;
  }

  @override
  Future<List<TaskEntity>> getAll(int limit, int offset) async {
    try {
      var tasks =
          await db.taskEntitys.where().offset(offset).limit(limit).findAll();

      LogService.logger
          .i("Getting tasks successful, offset: $offset, limit: $limit");

      return tasks;
    } catch (e) {
      LogService.logger.e("Failed to getting tasks", error: e);
      throw Exception("Error getting tasks");
    }
  }

  @override
  Future<TaskEntity?> getOne(int id) async {
    try {
      var task = await db.taskEntitys.get(id);
      LogService.logger.i("Retrive task succsseful with id: $id");
      return task;
    } catch (e) {
      LogService.logger.e("Failed to getting task with id: $id", error: e);
      throw Exception("Error getting task");
    }
  }

  @override
  Future<int> update(int id, TaskDto dto, [int? newCategoryId]) async {
    late int updatedId;

    try {
      var task = await db.taskEntitys.get(id);

      if (task == null) {
        LogService.logger.e("Task not found with id: $id");
        throw Exception("Task not found");
      }

      CategoryEntity? newCategory;

      if (newCategoryId != null) {
        newCategory = await categoryService.getOne(id);
      }

      task.title = dto.title ?? task.title;
      task.notate = dto.notate ?? task.notate;
      task.taskDate = dto.taskDate ?? task.taskDate;
      task.hasTime = dto.hasTime ?? task.hasTime;
      task.isFinished = dto.isFinished ?? task.isFinished;
      task.hasRepeats = dto.hasRepeats ?? task.hasRepeats;
      task.important = dto.important ?? task.important;
      task.isCopy = dto.isCopy ?? task.isCopy;
      task.color = dto.color ?? task.color;
      task.notificationId = dto.notificationId ?? task.notificationId;

      await db.writeTxn(() async {
        if (newCategory != null) {
          task.category.value = newCategory;
        }

        updatedId = await db.taskEntitys.put(task);
        await task.category.save();
      });
    } catch (e) {
      LogService.logger.e("Failed updating task with id: $id", error: e);
      throw Exception("Error updating task");
    }
    LogService.logger.i("Task updated successfully with id: $id");
    return updatedId;
  }

  @override
  Future<List<int>> saveAll(List<TaskEntity> tasks) async {
    late List<int> createdIds;

    try {
      await db.writeTxn(() async {
        createdIds = await saveAllInternal(tasks);
      });
    } catch (e) {
      LogService.logger.e("Failed save all tasks", error: e);
      throw Exception("Error saving tasks");
    }
    LogService.logger.i("All tasks created successfully");

    return createdIds;
  }

  @override
  Future<List<int>> saveAllInternal(List<TaskEntity> tasks) async {
    return await db.taskEntitys.putAll(tasks);
  }
}
