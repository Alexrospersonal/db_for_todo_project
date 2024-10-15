import 'package:db_for_todo_project/entities/entities_exports.dart';

class CategoryDto {
  String? name;
  String? emoji;

  CategoryDto({this.name, this.emoji});

  CategoryEntity toEntity() {
    var name = _getName();
    if (emoji != null) {
      return CategoryEntity(name: name, emoji: emoji!);
    }
    return CategoryEntity(name: name);
  }

  factory CategoryDto.fromEntity(CategoryEntity entity) {
    return CategoryDto(name: entity.name, emoji: entity.emoji);
  }

  bool validateName() {
    if (name == null || name!.isEmpty) {
      throw Exception("Category name is required but was not provided.");
    }
    return true;
  }

  bool validateEmoji() {
    if (emoji == null) {
      throw Exception("Category emoji is null");
    }
    return true;
  }

  String _getName() {
    validateName();
    return name!;
  }
}
