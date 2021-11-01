class DateTimeUtils {
  static int getNumberMissingDaysFromWeek(DateTime date) {
    int missingDaysStartWeek = DateTime(date.year, date.month, 0).weekday;
    return missingDaysStartWeek;
  }

  static int getPreviousMonth(DateTime date) {
    return date.month == 1 ? 12 : date.month - 1;
  }

  static int getPreviousMonthYear(DateTime date) {
    return date.month == 1 ? date.year - 1 : date.year;
  }

  static int getNextMonth(DateTime date) {
    return date.month == 12 ? 1 : date.month + 1;
  }

  static int getNextMonthYear(DateTime date) {
    return date.month == 12 ? date.year + 1 : date.year;
  }
}
