import 'package:flutter/material.dart';

class CalendarProvider extends ChangeNotifier {
  DateTime? selectedDate;
  DateTime visibleDate = DateTime.now();
  DateTime? minDate;
  DateTime? maxDate;

  CalendarProvider(
    DateTime? selectedDate,
    DateTime? focusedDate,
    DateTime? minDate,
    DateTime? maxDate,
  ) {
    this.selectedDate = selectedDate;
    this.minDate = minDate;
    this.maxDate = maxDate;
    if(focusedDate != null) {
      this.visibleDate = focusedDate;
    }
    if(selectedDate != null) {
      this.visibleDate = selectedDate;
    }
  }

  void setSelectedDate(DateTime selectedDate) {
    this.selectedDate = selectedDate;
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
}
