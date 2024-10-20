import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';

abstract interface class ITaskEntityService<U> implements BaseEntityService {
  ITaskEntityService(U db);
  Future<int> create();
  Future<int> update();
  Future<bool> delete(int id);
  Future<TaskEntity?> getOne(int id);
  Future<List<TaskEntity>> getAll(int limit, int offset);
}

class TaskEntityService implements ITaskEntityService {
  @override
  Future<int> create() {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<TaskEntity>> getAll(int limit, int offset) {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<TaskEntity?> getOne(int id) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<int> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
