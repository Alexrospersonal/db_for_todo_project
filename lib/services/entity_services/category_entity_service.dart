import 'package:db_for_todo_project/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/entities/entities_exports.dart';

abstract interface class ICategoryEntityService {
  Future<void> create();
  Future<void> update(int id, CategoryDto entity);
  Future<CategoryEntity> delete(int id);
  Future<CategoryEntity> getOne(int id);
  Future<List<CategoryEntity>> getAll();
}

class CategoryEntityService implements ICategoryEntityService {
  @override
  Future<void> create() {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<CategoryEntity> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryEntity>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<CategoryEntity> getOne(int id) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<void> update(int id, CategoryDto entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
