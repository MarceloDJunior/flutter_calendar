import 'package:calendar/src/model/calendar_mode.dart';
import 'package:flutter/material.dart';

class CalendarProvider extends ChangeNotifier {
  DateTime? selectedDate;
  DateTime? startDate;
  DateTime? endDate;
  DateTime visibleDate = DateTime.now();
  DateTime? minDate;
  DateTime? maxDate;
  CalendarMode? mode;

  CalendarProvider(
    DateTime? selectedDate,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? focusedDate,
    DateTime? minDate,
    DateTime? maxDate,
    CalendarMode? mode,
  ) {
    this.selectedDate = selectedDate;
    this.startDate = startDate;
    this.endDate = endDate;
    this.minDate = minDate;
    this.maxDate = maxDate;
    this.mode = mode;
    if (focusedDate != null) {
      this.visibleDate = focusedDate;
    }
    if (selectedDate != null) {
      this.visibleDate = selectedDate;
    }
    if (startDate != null) {
      this.visibleDate = startDate;
    }
  }

  void setSelectedDate(DateTime selectedDate) {
    this.selectedDate = selectedDate;
    notifyListeners();
  }

  void setStartDate(DateTime? startDate) {
    this.startDate = startDate;
    notifyListeners();
  }

  void setEndDate(DateTime? endDate) {
    this.endDate = endDate;
    notifyListeners();
  }

  void setVisibleDate(DateTime visibleDate) {
    this.visibleDate = visibleDate;
    notifyListeners();
  }

  void setMinDate(DateTime? minDate) {
    this.minDate = minDate;
    notifyListeners();
  }

  void setMaxDate(DateTime? maxDate) {
    this.maxDate = maxDate;
    notifyListeners();
  }

  bool isStartDate(DateTime date) {
    if (startDate == null || endDate == null) {
      return false;
    }
    return date.day == startDate!.day &&
        date.month == startDate!.month &&
        date.year == startDate!.year;
  }

  bool isEndDate(DateTime date) {
    if (endDate == null) {
      return false;
    }
    return date.day == endDate!.day &&
        date.month == endDate!.month &&
        date.year == endDate!.year;
  }

  bool isBetweenStartAndEndDate(DateTime date) {
    if (startDate == null || endDate == null) {
      return false;
    }
    return date.isAfter(startDate!) && date.isBefore(endDate!);
  }
}
