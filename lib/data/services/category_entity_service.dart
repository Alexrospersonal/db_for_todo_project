import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/base_entity_service.dart';
import 'package:db_for_todo_project/data/log_service.dart';
import 'package:isar/isar.dart';

abstract interface class ICategoryEntityService<U>
    implements BaseEntityService {
  ICategoryEntityService(U db);
  Future<int> create(CategoryDto categoryDto);
  Future<int> update(int id, CategoryDto categoryDto);
  Future<bool> delete(int id);
  Future<CategoryEntity?> getOne(int id);
  Future<List<CategoryEntity>> getAll(int limit, int offset);
}

class CategoryEntityService
    implements ICategoryEntityService<Isar>, BaseEntityService {
  final Isar db;
  const CategoryEntityService({required this.db});

  @override
  Future<int> create(CategoryDto categoryDto) async {
    var newCategory = categoryDto.toEntity();
    try {
      late int id;

      await db.writeTxn(() async {
        id = await db.categoryEntitys.put(newCategory);
        LogService.logger.i('Category created successfully with id: $id');
      });
      return id;
    } catch (e) {
      LogService.logger.e('Failed to create category: ', error: e);
      throw Exception("Error creating category");
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      late bool deletedId;

      await db.writeTxn(() async {
        deletedId = await db.categoryEntitys.delete(id);
      });
      LogService.logger.i('Category deleted successfully with id: $deletedId');
      return deletedId;
    } catch (e) {
      LogService.logger.e('Failed to deleting category: ', error: e);
      throw Exception("Error deleting category");
    }
  }

  @override
  Future<List<CategoryEntity>> getAll(int limit, int offset) async {
    try {
      var categories = await db.categoryEntitys
          .where()
          .offset(offset)
          .limit(limit)
          .findAll();

      LogService.logger
          .i("Getting categories successful, offset: $offset, limit: $limit");

      return categories;
    } catch (e) {
      LogService.logger.e("Failed to getting categories", error: e);
      throw Exception("Error getting categories");
    }
  }

  @override
  Future<CategoryEntity?> getOne(int id) async {
    try {
      var category = await db.categoryEntitys.get(id);
      LogService.logger.i("Retrive category succsseful with id: $id");
      return category;
    } catch (e) {
      LogService.logger.e("Failed to getting category", error: e);
      throw Exception("Error getting category");
    }
  }

  @override
  Future<int> update(int id, CategoryDto categoryDto) async {
    try {
      var category = await db.categoryEntitys.get(id);

      if (category == null) {
        LogService.logger.e("Category not found with id: $id");
        throw Exception("Category not found");
      }

      late int updatedId;

      await db.writeTxn(() async {
        if (categoryDto.validateName()) {
          category.name = categoryDto.name!;
        }

        if (categoryDto.validateEmoji()) {
          category.emoji = categoryDto.emoji!;
        }
        updatedId = await db.categoryEntitys.put(category);
      });

      LogService.logger.i("Category updated successfully with id: $id");
      return updatedId;
    } catch (e) {
      LogService.logger.e("Failed updating category with id: $id", error: e);
      throw Exception("Error updating category");
    }
  }
}
