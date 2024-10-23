import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/task_entity/task_entity.dart';
import 'package:flutter/material.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group("Test task dto: create, copyWith, toEntity, fromEntity", () {
    test("Should create task DTO", () {
      var date = DateTime.now();

      var dto = TaskDto(
          title: "Test 1",
          notate: "Test notate",
          taskDate: date,
          color: Colors.red.value,
          isCopy: false,
          hasTime: false,
          hasRepeats: false,
          important: true);

      expect(dto.title, "Test 1");
      expect(dto.notate, "Test notate");
      expect(dto.taskDate, date);
      expect(dto.color, Colors.red.value);
      expect(dto.isCopy, false);
      expect(dto.hasTime, false);
      expect(dto.hasRepeats, false);
      expect(dto.important, true);
    });

    test("Should return copy of task from copyWith function", () {
      var date = DateTime.now();

      var dto = TaskDto(
          title: "Test 1",
          notate: "Test notate",
          taskDate: date,
          color: Colors.red.value,
          isCopy: false,
          hasTime: false,
          hasRepeats: false,
          important: true);

      var copyDto = dto.copyWith(title: "Copy of task");

      expect(copyDto.title, "Copy of task");

      expect(dto.notate, copyDto.notate);
      expect(dto.taskDate, copyDto.taskDate);
      expect(dto.color, copyDto.color);
      expect(dto.isCopy, copyDto.isCopy);
      expect(dto.hasTime, copyDto.hasTime);
      expect(dto.hasRepeats, copyDto.hasRepeats);
      expect(dto.important, copyDto.important);
    });

    test("Should return TaskEntity from toEntity function", () {
      var date = DateTime.now();

      var dto = TaskDto(
          title: "Test 1",
          notate: "Test notate",
          taskDate: date,
          color: Colors.red.value,
          isCopy: false,
          hasTime: false,
          hasRepeats: false,
          important: true);

      var entity = dto.toEntity();

      expect(entity.title, "Test 1");
      expect(entity.notate, "Test notate");
      expect(entity.taskDate, date);
      expect(entity.color, Colors.red.value);
      expect(entity.isCopy, false);
      expect(entity.hasTime, false);
      expect(entity.hasRepeats, false);
      expect(entity.important, true);
    });

    test("Should return Task DTO from TaskEntity with fromEntity function", () {
      var date = DateTime.now();

      var entity = TaskEntity(title: "Test 1");
      entity = entity.copyWith(
          notate: "Test notate",
          taskDate: date,
          color: Colors.red.value,
          isCopy: false,
          hasTime: false,
          hasRepeats: false,
          important: true);

      var dto = TaskDto.fromEntity(entity);

      expect(dto.title, "Test 1");
      expect(dto.notate, "Test notate");
      expect(dto.taskDate, date);
      expect(dto.color, Colors.red.value);
      expect(dto.isCopy, false);
      expect(dto.hasTime, false);
      expect(dto.hasRepeats, false);
      expect(dto.important, true);
    });
  });
}
