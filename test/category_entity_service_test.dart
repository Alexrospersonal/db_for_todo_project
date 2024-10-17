import 'package:db_for_todo_project/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/services/entities_services_exports.dart';
import 'package:flutter_test/flutter_test.dart';

import 'common/isar_test_service.dart';

// TODO: написати тести
void main() async {
  // var testTempPath = prepareIsarTempEnvirement();

  // late Isar db;
  // late CategoryEntityService categoryEntityService;

  // setUp(() async {
  //   db = await openTempIsar(schemas, testTempPath);
  //   categoryEntityService = CategoryEntityService(db: db);
  // });

  // tearDownAll(() async {
  //   serviceController.db.close();
  //   clearFolder(testTempPath);
  // });

  var serviceController = IsarTestService<CategoryEntityService>();

  setUp(() async {
    await serviceController
        .initIsarAndService((db) => CategoryEntityService(db: db));
  });

  tearDownAll(() async {
    serviceController.closeIsarAndClearTempFolder();
  });

  test("Should create a new category in the database with id 1 and name",
      () async {
    var service = serviceController.service;
    var categoryDto = CategoryDto(emoji: "😡", name: "test");

    final createdId = await service.create(categoryDto);
    final category = await service.getOne(createdId);

    expect(createdId, 1);
    expect(categoryDto.name, category!.name);
  });
}
