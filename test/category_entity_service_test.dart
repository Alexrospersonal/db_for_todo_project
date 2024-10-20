import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import 'common/isar_test_service.dart';

void main() async {
  var serviceController = IsarTestService<ICategoryEntityService<Isar>>();

  group("Test CRUD CategoryService", () {
    setUpAll(() async {
      await serviceController
          .initIsarAndService((db) => CategoryEntityService(db: db));
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
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

    test("Should get the category by Id, id: 1", () async {
      var service = serviceController.service;

      var categoryId = 1;
      var category = await service.getOne(categoryId);

      expect(category!.id, 1);
    });

    test("Should return null ", () async {
      var categoryId = 99;

      var service = serviceController.service;
      var nullCategory = await service.getOne(categoryId);
      expect(nullCategory, null);
    });

    test("Should update name of the category width id", () async {
      var service = serviceController.service;
      var nameToUpdate = "New";

      var categoryId = 1;
      var categoryDto = CategoryDto(emoji: null, name: nameToUpdate);
      var updatedId = await service.update(1, categoryDto);

      var updatedCategory = await service.getOne(1);

      expect(categoryId, updatedId);
      expect(updatedCategory!.name, nameToUpdate);
      expect(updatedCategory.emoji, "😡");
    });

    test("Should update emoji of the category width id", () async {
      var service = serviceController.service;
      var oldName = "New";
      var emojiToUpdate = "😘";

      var categoryId = 1;
      var categoryDto = CategoryDto(emoji: emojiToUpdate, name: null);
      var updatedId = await service.update(1, categoryDto);

      var updatedCategory = await service.getOne(1);

      expect(categoryId, updatedId);
      expect(updatedCategory!.name, oldName);
      expect(updatedCategory.emoji, emojiToUpdate);
    });

    test("Should delete first category witd id 1", () async {
      var service = serviceController.service;
      var categoryId = 1;
      var result = await service.delete(categoryId);

      var nullCategory = await service.getOne(categoryId);

      expect(result, true);
      expect(nullCategory, null);
    });

    test("Should return false, delete by wrong id", () async {
      var service = serviceController.service;
      var wrongId = 99;

      var result = await service.delete(wrongId);

      expect(result, false);
    });

    test("Should return 3 first category from Db with limit 3, offset 0",
        () async {
      var service = serviceController.service;
      var categoryDto1 = CategoryDto(emoji: "😡", name: "test1");
      var categoryDto2 = CategoryDto(emoji: "😡", name: "test2");
      var categoryDto3 = CategoryDto(emoji: "😡", name: "test3");

      await service.create(categoryDto1);
      await service.create(categoryDto2);
      await service.create(categoryDto3);

      var categories = await service.getAll(3, 0);

      expect(categories.length, 3);
      expect(categories[0].id, 2);
      expect(categories[1].id, 3);
      expect(categories[2].id, 4);
    });
  });
}
