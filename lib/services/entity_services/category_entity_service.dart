import 'package:db_for_todo_project/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/entities/entities_exports.dart';
import 'package:db_for_todo_project/services/db_service.dart';
import 'package:db_for_todo_project/services/log_service.dart';
import 'package:isar/isar.dart';

abstract interface class ICategoryEntityService {
  Future<int> create(CategoryDto categoryDto);
  Future<void> update(int id, CategoryDto categoryDto);
  Future<bool> delete(int id);
  Future<CategoryEntity?> getOne(int id);
  Future<List<CategoryEntity>> getAll(int limit, int offset);
}

class CategoryEntityService implements ICategoryEntityService {
  const CategoryEntityService();

  @override
  Future<int> create(CategoryDto categoryDto) async {
    var newCategory = categoryDto.toEntity();
    try {
      var id = await db.categoryEntitys.put(newCategory);
      LogService.logger.i('Category created successfully with id: $id');
      return id;
    } catch (e) {
      LogService.logger.e('Failed to create category: ', error: e);
      throw Exception("Error creating category");
    }
  }

  @override
  Future<bool> delete(int id) async {
    try {
      var deletedId = await db.categoryEntitys.delete(id);
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
  Future<void> update(int id, CategoryDto categoryDto) async {
    try {
      var category = await db.categoryEntitys.get(id);

      if (category == null) {
        LogService.logger.e("Category not found with id: $id");
        throw Exception("Category not found");
      }

      await db.writeTxn(() async {
        if (categoryDto.validateName()) {
          category.name = categoryDto.name!;
        }

        if (categoryDto.validateEmoji()) {
          category.emoji = categoryDto.emoji!;
        }
        db.categoryEntitys.put(category);
      });
      LogService.logger.i("Category updated successfully with id: $id");
    } catch (e) {
      LogService.logger.e("Failed updating category with id: $id", error: e);
      throw Exception("Error updating category");
    }
  }
}
