import 'package:calendar/src/model/calendar_mode.dart';
import 'package:calendar/src/providers/calendar_provider.dart';
import 'package:flutter/material.dart';
import 'package:calendar/src/utils/datetime_utils.dart';
import 'package:calendar/src/widgets/day.dart';
import 'package:provider/provider.dart';

const NUMBER_OF_DAYS = 42;

class Days extends StatelessWidget {
  final DateTime visibleDate;
  final Function? onChange;

  Days({
    Key? key,
    required this.visibleDate,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CalendarProvider provider = Provider.of<CalendarProvider>(context);
    DateTime? selectedDate = provider.selectedDate;
    DateTime? startDate = provider.startDate;
    DateTime? endDate = provider.endDate;
    DateTime? minDate = provider.minDate;
    DateTime? maxDate = provider.maxDate;
    CalendarMode mode = provider.mode ?? CalendarMode.DATE_PICKER;

    final int numberOfDays =
        DateUtils.getDaysInMonth(visibleDate.year, visibleDate.month);
    final List<int> days = List.generate(numberOfDays, (index) => index + 1);

    _onDateChange(DateTime date) {
      Provider.of<CalendarProvider>(context, listen: false)
          .setSelectedDate(date);
      onChange?.call(date);
    }

    _onDateRangeChange(DateTime date) {
      DateTime? newStartDate = startDate;
      DateTime? newEndDate = endDate;
      if (startDate != null && endDate != null) {
        newStartDate = null;
      }
      if (endDate != null) {
        newEndDate = null;
      }
      if (newStartDate != null && newStartDate.isBefore(date)) {
        newEndDate = date;
      } else {
        newStartDate = date;
      }
      Provider.of<CalendarProvider>(context, listen: false)
          .setStartDate(newStartDate);
      Provider.of<CalendarProvider>(context, listen: false)
          .setEndDate(newEndDate);
      // TODO: Call onDateRangeChange
    }

    _onDateClick(DateTime date) {
      if (mode == CalendarMode.DATE_PICKER) {
        _onDateChange(date);
      } else {
        _onDateRangeChange(date);
      }
    }

    _onSelectedMonthChange(DateTime date) {
      Provider.of<CalendarProvider>(context, listen: false)
          .setVisibleDate(date);
    }

    _getLastDaysFromPreviousMonth() {
      int previousMonth = DateTimeUtils.getPreviousMonth(visibleDate);
      int numberOfDaysPreviousMonth = DateUtils.getDaysInMonth(
          DateTimeUtils.getPreviousMonthYear(visibleDate), previousMonth);

      DateTime firstRemainingDayLastMonth = DateTime(
          DateTimeUtils.getPreviousMonthYear(visibleDate),
          previousMonth,
          numberOfDaysPreviousMonth -
              DateTimeUtils.getNumberMissingDaysFromWeek(visibleDate));

      List<int> lastDaysFromPreviousMonth = List.generate(
          numberOfDaysPreviousMonth - firstRemainingDayLastMonth.day + 1,
          (index) => firstRemainingDayLastMonth.day + index);

      return lastDaysFromPreviousMonth;
    }

    _getMissingDaysFromNextMonth() {
      int totalDays = days.length + _getLastDaysFromPreviousMonth().length;
      int missingDaysFromNextMonth = NUMBER_OF_DAYS - totalDays;
      DateTime firstDayNextMonth = DateTime(
        DateTimeUtils.getNextMonthYear(visibleDate),
        DateTimeUtils.getNextMonth(visibleDate),
        1,
      );

      List<int> daysFromNextMonth = List.generate(
          missingDaysFromNextMonth - firstDayNextMonth.day + 1,
          (index) => firstDayNextMonth.day + index);

      return daysFromNextMonth;
    }

    bool _isDisabled(DateTime date) {
      if (minDate != null && date.isBefore(minDate)) {
        return true;
      }
      if (maxDate != null && date.isAfter(maxDate)) {
        return true;
      }
      return false;
    }

    bool _isSelected(DateTime date) {
      if (mode == CalendarMode.DATE_PICKER) {
        return selectedDate != null &&
            selectedDate.day == date.day &&
            selectedDate.month == date.month &&
            selectedDate.year == date.year;
      } else {
        bool isSelected = false;
        if (startDate != null &&
            startDate.day == date.day &&
            startDate.month == date.month &&
            startDate.year == date.year) {
          isSelected = true;
        }
        if (endDate != null &&
            endDate.day == date.day &&
            endDate.month == date.month &&
            endDate.year == date.year) {
          isSelected = true;
        }
        return isSelected;
      }
    }

    bool _isStartDate(DateTime date) {
      return Provider.of<CalendarProvider>(context, listen: false)
          .isStartDate(date);
    }

    bool _isEndDate(DateTime date) {
      return Provider.of<CalendarProvider>(context, listen: false)
          .isEndDate(date);
    }

    bool _isBetweenDates(DateTime date) {
      if (mode == CalendarMode.DATE_PICKER) {
        return false;
      } else {
        return Provider.of<CalendarProvider>(context, listen: false)
            .isBetweenStartAndEndDate(date);
      }
    }

    _daysFromPreviousMonth() {
      return _getLastDaysFromPreviousMonth().map((day) {
        DateTime date = DateTime(
          DateTimeUtils.getPreviousMonthYear(visibleDate),
          DateTimeUtils.getPreviousMonth(visibleDate),
          day,
        );
        return Day(
          day: day,
          selected: _isSelected(date),
          interval: _isBetweenDates(date),
          startDate: _isStartDate(date),
          endDate: _isEndDate(date),
          unfocused: true,
          disabled: _isDisabled(date),
          onClick: () {
            _onDateClick(date);
            _onSelectedMonthChange(date);
          },
        );
      }).toList();
    }

    _daysFromCurrentMonth() {
      return days.map((day) {
        DateTime date = DateTime(visibleDate.year, visibleDate.month, day);
        return Day(
          day: day,
          disabled: _isDisabled(date),
          selected: _isSelected(date),
          interval: _isBetweenDates(date),
          startDate: _isStartDate(date),
          endDate: _isEndDate(date),
          onClick: () {
            _onDateClick(date);
          },
        );
      }).toList();
    }

    _daysFromNextMonth() {
      return _getMissingDaysFromNextMonth().map((day) {
        DateTime date = DateTime(DateTimeUtils.getNextMonthYear(visibleDate),
            DateTimeUtils.getNextMonth(visibleDate), day);
        return Day(
          day: day,
          selected: _isSelected(date),
          interval: _isBetweenDates(date),
          startDate: _isStartDate(date),
          endDate: _isEndDate(date),
          unfocused: true,
          disabled: _isDisabled(date),
          onClick: () {
            _onDateClick(date);
            _onSelectedMonthChange(date);
          },
        );
      }).toList();
    }

    return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        crossAxisCount: 7,
        children: [
          ..._daysFromPreviousMonth(),
          ..._daysFromCurrentMonth(),
          ..._daysFromNextMonth(),
        ]);
  }
}
