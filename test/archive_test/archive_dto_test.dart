import 'dart:convert';

import 'package:db_for_todo_project/data/dtos/dtos_exports.dart';
import 'package:db_for_todo_project/data/entities/entities_exports.dart';
import 'package:flutter/material.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group("Test archive dto", () {
    test("Create DTO", () {
      var taskDate = DateTime.now();

      var taskDto = TaskDto(
          title: "Write code",
          notate: "Write the best code",
          taskDate: taskDate,
          color: Colors.red.value,
          notificationId: 877766,
          isCopy: false,
          hasRepeats: true,
          hasTime: true,
          important: true,
          isFinished: false);

      var finishedDate = DateTime.now();

      var task = taskDto.toEntity();

      var jsonString = jsonEncode(task.toJson());

      var archive = ArchiveDto(
          originalId: 1,
          finishedDate: finishedDate,
          isFinished: false,
          taskData: jsonString);

      expect(archive.originalId, 1);
      expect(archive.taskData, jsonString);

      expect(archive.isFinished, false);
      expect(archive.finishedDate, finishedDate);
    });

    test("Should create ArchiveEntity", () {
      var taskDate = DateTime.now();

      var taskDto = TaskDto(
          title: "Write code",
          notate: "Write the best code",
          taskDate: taskDate,
          color: Colors.red.value,
          notificationId: 877766,
          isCopy: false,
          hasRepeats: true,
          hasTime: true,
          important: true,
          isFinished: false);

      var finishedDate = DateTime.now();

      var task = taskDto.toEntity();

      var jsonString = jsonEncode(task.toJson());

      var archive = ArchiveDto(
          originalId: 1,
          finishedDate: finishedDate,
          isFinished: false,
          taskData: jsonString);

      var archiveEntity = archive.toEntity();

      expect(archiveEntity.originalId, 1);
      expect(archiveEntity.taskData, jsonString);

      expect(archiveEntity.isFinished, false);
      expect(archiveEntity.finishedDate, finishedDate);
    });

    test("from Entity", () {
      var taskDate = DateTime.now();

      var taskDto = TaskDto(
          title: "Write code",
          notate: "Write the best code",
          taskDate: taskDate,
          color: Colors.red.value,
          notificationId: 877766,
          isCopy: false,
          hasRepeats: true,
          hasTime: true,
          important: true,
          isFinished: false);

      var finishedDate = DateTime.now();

      var task = taskDto.toEntity();

      var jsonString = jsonEncode(task.toJson());

      var archive = ArchivedTaskEntity(
          originalId: 1,
          finishedDate: finishedDate,
          isFinished: false,
          taskData: jsonString);

      var dto = ArchiveDto.fromEntity(archive);

      expect(dto.originalId, 1);
      expect(dto.taskData, jsonString);

      expect(dto.isFinished, false);
      expect(dto.finishedDate, finishedDate);
    });
  });
}
