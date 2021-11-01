import 'package:calendar/src/providers/calendar_provider.dart';
import 'package:calendar/src/utils/datetime_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  Header({
    Key? key,
  }) : super(key: key);

  void changeDate(BuildContext context, DateTime date) {
    Provider.of<CalendarProvider>(context, listen: false).setVisibleDate(date);
  }

  @override
  Widget build(BuildContext context) {
    DateTime visibleDate = Provider.of<CalendarProvider>(context).visibleDate;

    final String currentDateFormatted =
        DateFormat('LLLL yyyy').format(visibleDate);

    _goToNextMonth() {
      DateTime newDate = DateTime(
        DateTimeUtils.getNextMonthYear(visibleDate),
        DateTimeUtils.getNextMonth(visibleDate),
        1,
      );
      changeDate(context, newDate);
    }

    _goToPreviousMonth() {
      DateTime newDate = DateTime(
        DateTimeUtils.getPreviousMonthYear(visibleDate),
        DateTimeUtils.getPreviousMonth(visibleDate),
        1,
      );
      changeDate(context, newDate);
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            currentDateFormatted,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(17),
          child: Container(
            height: 34,
            width: 34,
            child: Icon(Icons.keyboard_arrow_left),
          ),
          onTap: _goToPreviousMonth,
        ),
        SizedBox(
          width: 16,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(17),
          child: Container(
            height: 34,
            width: 34,
            child: Icon(Icons.keyboard_arrow_right),
          ),
          onTap: _goToNextMonth,
        ),
      ],
    );
  }
}
