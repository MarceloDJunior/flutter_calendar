import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekDays extends StatelessWidget {
  const WeekDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime _today = DateTime.now();
    final DateTime _firstDayOfWeek =
        _today.subtract(new Duration(days: _today.weekday));

    List<String> shortWeekDaysArray = [];

    for (int i = 0; i < 7; i++) {
      shortWeekDaysArray.add(
        DateFormat('EEE').format(_firstDayOfWeek.add(Duration(days: i))),
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 30, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: shortWeekDaysArray
            .map(
              (day) => Expanded(
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
