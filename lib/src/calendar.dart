import 'package:calendar/src/calendar_module.dart';
import 'package:calendar/src/model/calendar_mode.dart';
import 'package:calendar/src/providers/calendar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Calendar extends StatelessWidget {
  final DateTime? selectedDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? focusedDate;
  final Function? onChange;
  final CalendarMode? mode;

  const Calendar({
    Key? key,
    this.selectedDate,
    this.startDate,
    this.endDate,
    this.minDate,
    this.maxDate,
    this.onChange,
    this.focusedDate,
    this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CalendarProvider(
            selectedDate,
            startDate,
            endDate,
            focusedDate,
            minDate,
            maxDate,
            mode,
          ),
        ),
      ],
      child: CalendarModule(
        onChange: onChange,
      ),
    );
  }
}
