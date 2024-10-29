class TaskDateManagerService {
  const TaskDateManagerService();

  DateTime getNextDate(List<int> weekdays, DateTime startDate) {
    var startDateInWeek = startDate.weekday;

    int closestDay = getClosestDay(weekdays, startDateInWeek);

    late int addDaysToDate =
        calculateDaysUntilNextDay(startDateInWeek, closestDay);

    return startDate.add(Duration(days: addDaysToDate));
  }

  int getClosestDay(List<int> weekdays, int startDateInWeek) {
    return weekdays.firstWhere((weekday) => weekday >= startDateInWeek,
        orElse: () => weekdays[0]);
  }

  int calculateDaysUntilNextDay(int startDateInWeek, int closesetDay) {
    int addDaysToDate = 0;

    switch (startDateInWeek.compareTo(closesetDay)) {
      case 0:
        addDaysToDate = 0;
      case 1:
        addDaysToDate = (7 - startDateInWeek) + closesetDay;
      case -1:
        addDaysToDate = closesetDay - startDateInWeek;
    }

    return addDaysToDate;
  }

  List<DateTime?> filterNonNullTimes(List<DateTime?> repeatDuringDay) {
    return repeatDuringDay.where((time) => time != null).toList();
  }

  DateTime joinDateAndTime(DateTime toDate, DateTime fromTime) {
    return toDate.copyWith(hour: fromTime.hour, minute: fromTime.minute);
  }
}
