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
    DateTime? minDate = provider.minDate;
    DateTime? maxDate = provider.maxDate;

    final int numberOfDays =
        DateUtils.getDaysInMonth(visibleDate.year, visibleDate.month);
    final List<int> days = List.generate(numberOfDays, (index) => index + 1);

    _onDateChange(DateTime date) {
      Provider.of<CalendarProvider>(context, listen: false)
          .setSelectedDate(date);
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

    _daysFromPreviousMonth() {
      return _getLastDaysFromPreviousMonth().map((day) {
        DateTime date = DateTime(
          DateTimeUtils.getPreviousMonthYear(visibleDate),
          DateTimeUtils.getPreviousMonth(visibleDate),
          day,
        );
        return Day(
          day: day,
          selected: day == selectedDate?.day &&
              DateTimeUtils.getPreviousMonth(visibleDate) ==
                  selectedDate?.month &&
              DateTimeUtils.getPreviousMonthYear(visibleDate) ==
                  selectedDate?.year,
          unfocused: true,
          disabled: _isDisabled(date),
          onClick: () {
            _onDateChange(date);
            _onSelectedMonthChange(date);
            onChange?.call(date);
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
          selected: day == selectedDate?.day &&
              visibleDate.month == selectedDate?.month &&
              visibleDate.year == selectedDate?.year,
          onClick: () {
            _onDateChange(date);
            onChange?.call(date);
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
          selected: day == selectedDate?.day &&
              DateTimeUtils.getNextMonth(visibleDate) == selectedDate?.month &&
              DateTimeUtils.getNextMonthYear(visibleDate) == selectedDate?.year,
          unfocused: true,
          disabled: _isDisabled(date),
          onClick: () {
            _onDateChange(date);
            _onSelectedMonthChange(date);
            onChange?.call(date);
          },
        );
      }).toList();
    }

    return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(2),
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        crossAxisCount: 7,
        children: [
          ..._daysFromPreviousMonth(),
          ..._daysFromCurrentMonth(),
          ..._daysFromNextMonth(),
        ]);
  }
}
