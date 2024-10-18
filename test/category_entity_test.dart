import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';

import 'package:isar/isar.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'common/isar_test_service.dart';

void main() async {
  var serviceController = IsarTestService<ICategoryEntityService<Isar>>();

  group("Test Category Entity", () {
    setUpAll(() async {
      await serviceController.initIsar();
    });

    tearDownAll(() async {
      await serviceController.closeIsarAndClearTempFolder();
    });

    test("Test create entity", () async {
      var db = serviceController.db;
      var newEntity = CategoryEntity(emoji: "😡", name: "test1");

      late int createdId;

      await db.writeTxn(() async {
        createdId = await db.categoryEntitys.put(newEntity);
      });

      expect(createdId, 1);
    });

    test("Test toString method in CategoryEntity", () async {
      var db = serviceController.db;
      int id = 1;

      var category = await db.categoryEntitys.get(id);
      expect(category.toString(), "😡 test1");
    });

    test("Test toJson method in CategoryEntity", () async {
      var db = serviceController.db;
      int id = 1;

      var category = await db.categoryEntitys.get(id);

      var expectedJsonObj = {"id": 1, "name": "test1", "emoji": "😡"};

      var categoryJsonObj = category!.toJson();

      expect(expectedJsonObj["id"], categoryJsonObj["id"]);
      expect(expectedJsonObj["name"], categoryJsonObj["name"]);
      expect(expectedJsonObj["emoji"], categoryJsonObj["emoji"]);
    });

    test("Test equals menthod in CategoryEntity", () async {
      var db = serviceController.db;
      int id = 1;

      var category1 = await db.categoryEntitys.get(id);
      var category2 = await db.categoryEntitys.get(id);

      var equalsResult = category1 == category2;

      expect(equalsResult, true);
    });
  });
}
