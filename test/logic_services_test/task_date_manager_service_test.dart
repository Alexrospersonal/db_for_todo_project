import 'package:db_for_todo_project/domain/logic_services/task_date_manager_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Testing the TaskDateManager, work with times and dates", () {
    var taskDateManager = const TaskDateManagerService();
    test("Should return a new datetime from joining date and date with time",
        () {
      var date = DateTime(2024, 10, 16);
      var time = DateTime.now();
      var expectedDateTime =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);

      var joinedDate = taskDateManager.joinDateAndTime(date, time);

      expect(joinedDate, expectedDateTime);
    });

    test("Should return filtered list of dateTime from filterNonNullTimes", () {
      var date = DateTime.now();
      var listWithTimes = [null, null, date, null, date];

      var filteredList = taskDateManager.filterNonNullTimes(listWithTimes);
      expect(filteredList.length, 2);
      expect(filteredList[0], date);
      expect(filteredList[1], date);
    });

    test("Should return empty list of dateTime from filterNonNullTimes", () {
      var listWithTimes = [null, null, null, null, null];

      var filteredList = taskDateManager.filterNonNullTimes(listWithTimes);
      expect(filteredList.length, 0);
    });

    test("Should return days until next day, value: 7", () {
      var startDateInWeek = 0;
      int closesetDay = 7;

      var filteredList = taskDateManager.calculateDaysUntilNextDay(
          startDateInWeek, closesetDay);
      expect(filteredList, 7);
    });

    test("Should return days until next day, value: 5", () {
      var startDateInWeek = 1;
      int closesetDay = 6;

      var filteredList = taskDateManager.calculateDaysUntilNextDay(
          startDateInWeek, closesetDay);
      expect(filteredList, 5);
    });

    test("Should return days until next day, value: 4", () {
      var startDateInWeek = 4;
      int closesetDay = 1;

      var filteredList = taskDateManager.calculateDaysUntilNextDay(
          startDateInWeek, closesetDay);
      expect(filteredList, 4);
    });

    test("Should return days until next day, value: 0", () {
      var startDateInWeek = 6;
      int closesetDay = 6;

      var filteredList = taskDateManager.calculateDaysUntilNextDay(
          startDateInWeek, closesetDay);
      expect(filteredList, 0);
    });

    test("Should return days until next day, value: 2", () {
      var startDateInWeek = 2;
      int closesetDay = 4;

      var filteredList = taskDateManager.calculateDaysUntilNextDay(
          startDateInWeek, closesetDay);
      expect(filteredList, 2);
    });

    test("Should return days until next day, value: 6", () {
      var filteredList = taskDateManager.calculateDaysUntilNextDay(6, 5);
      expect(filteredList, 6);
    });

    test("Should return days until next day, value: 3", () {
      var startDate = DateTime(2024, 11, 2).weekday;

      var filteredList =
          taskDateManager.calculateDaysUntilNextDay(startDate, 2);
      expect(filteredList, 3);
    });

    test("Should return days closest day, value: 3", () {
      var closestDay = taskDateManager.getClosestDay([1, 2], 2);
      expect(closestDay, 2);
    });

    test("Should return days closest day, value: 1", () {
      var closestDay = taskDateManager.getClosestDay([1, 2], 5);
      expect(closestDay, 1);
    });

    test("Should return days closest day, value: 4", () {
      var closestDay = taskDateManager.getClosestDay([4, 6], 1);
      expect(closestDay, 4);
    });

    test("Shoul return a new date: DateTime(2024, 11, 5)", () {
      var startDate = DateTime(2024, 11, 2);
      var expectedDate = DateTime(2024, 11, 5);
      var res = taskDateManager.getNextDate([2, 4], startDate);
      expect(res, expectedDate);
    });

    test("Shoul return a new date: DateTime(2024, 11, 4)", () {
      var startDate = DateTime(2024, 10, 30); // weekday 3
      var expectedDate = DateTime(2024, 11, 4);
      var res = taskDateManager.getNextDate([1, 2], startDate);
      expect(res, expectedDate);
    });

    test("Shoul return a new date: DateTime(2024, 11, 30)", () {
      var startDate = DateTime(2024, 10, 30); // weekday 3
      var res = taskDateManager.getNextDate([1, 2, 3], startDate);
      expect(res, startDate);
    });
  });
}
