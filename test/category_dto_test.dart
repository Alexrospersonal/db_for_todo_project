import 'package:db_for_todo_project/dtos/dtos_exports.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Test start, creating category DTO with name and emoji', () {
    var dto = CategoryDto(emoji: "😡", name: "test1");
    test('Category dto should be created with name', () {
      expect(dto.name, "test1");
    });

    test('Category dto should be created with emoji', () {
      expect(dto.emoji, "😡");
    });

    var newCategoryEntity = dto.toEntity();

    test('Test CategoryDto validation and toEntity exception', () {
      expect(newCategoryEntity.name, dto.name);
      expect(newCategoryEntity.emoji, dto.emoji);
    });
  });

  group('Test throwing excecption when name is null and invoke dto.toEntity()',
      () {
    test("Category DTO should throw exception when name is null", () {
      var dto = CategoryDto(emoji: "😡", name: null);

      expect(
          () => dto.toEntity(),
          throwsA(isA<Exception>().having(
              (e) => e.toString(),
              "Contains error message",
              contains("Category name is required but was not provided."))));
    });

    test("Category DTO should throw exception when name is empty", () {
      var dto = CategoryDto(emoji: "😡", name: "");

      expect(
          () => dto.toEntity(),
          throwsA(isA<Exception>().having(
              (e) => e.toString(),
              "Contains error message",
              contains("Category name is required but was not provided."))));
    });
  });
}
