import 'package:isar/isar.dart';

import '../entities_exports.dart';

part 'category_entity.g.dart';

@collection
class CategoryEntity {
  Id id = Isar.autoIncrement;
  String name;
  String emoji;

  @Backlink(to: 'category')
  final IsarLinks<TaskEntity> tasks = IsarLinks<TaskEntity>();

  CategoryEntity({required this.name, this.emoji = ""});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryEntity &&
        other.id == id &&
        other.name == name &&
        other.emoji == emoji;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ emoji.hashCode;

  @override
  String toString() => "$emoji $name";

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "emoji": emoji};
  }
}
