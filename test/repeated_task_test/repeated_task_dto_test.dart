import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:db_for_todo_project/data/services/entities_services_exports.dart';
import 'package:isar/isar.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../common/isar_test_service.dart';

void main() {
  group("Test repeated task dto", () {
    var serviceController = IsarTestService<BaseEntityService<Isar>>();

    setUpAll(() async {
      await serviceController.initIsar();
    });

    test("Should create a repeatedTaskDto", () async {
      var repeatedTaskDto = RepeatedTaskDto(
          repeatDuringWeek: [1, 3, 5],
          endDateOfRepeatedly: DateTime(2024, 11, 15),
          repeatDuringDay: null,
          isFinished: false);

      expect(repeatedTaskDto.repeatDuringWeek![0], 1);
      expect(repeatedTaskDto.repeatDuringWeek![1], 3);
      expect(repeatedTaskDto.repeatDuringWeek![2], 5);

      expect(repeatedTaskDto.endDateOfRepeatedly, DateTime(2024, 11, 15));

      expect(repeatedTaskDto.repeatDuringDay, isNull);
    });

    test("Should return task repeated dto from Entity", () async {
      var entity = RepeatedTaskEntity();

      entity.repeatDuringWeek = [1, 3, 5];
      entity.endDateOfRepeatedly = DateTime(2024, 11, 15);
      entity.repeatDuringDay = null;
      entity.isFinished = false;

      var repeatedTaskDto = RepeatedTaskDto.fromEntity(entity);

      expect(repeatedTaskDto.repeatDuringWeek![0], 1);
      expect(repeatedTaskDto.repeatDuringWeek![1], 3);
      expect(repeatedTaskDto.repeatDuringWeek![2], 5);

      expect(repeatedTaskDto.endDateOfRepeatedly, DateTime(2024, 11, 15));

      expect(repeatedTaskDto.repeatDuringDay, isNull);
    });

    test("Should return RepeatedTaskEntity from DTO", () {
      var repeatedTaskDto = RepeatedTaskDto(
          repeatDuringWeek: [1, 3, 5],
          endDateOfRepeatedly: DateTime(2024, 11, 15),
          repeatDuringDay: null,
          isFinished: false);
      var entity = repeatedTaskDto.toEntity();

      expect(entity.repeatDuringWeek![0], 1);
      expect(entity.repeatDuringWeek![1], 3);
      expect(entity.repeatDuringWeek![2], 5);

      expect(entity.endDateOfRepeatedly, DateTime(2024, 11, 15));

      expect(entity.repeatDuringDay, isNull);
    });
  });
}
