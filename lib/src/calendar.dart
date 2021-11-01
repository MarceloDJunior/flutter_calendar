import 'package:calendar/src/calendar_module.dart';
import 'package:calendar/src/providers/calendar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Calendar extends StatelessWidget {
  final DateTime? selectedDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final DateTime? focusedDate;
  final Function? onChange;

  const Calendar({
    Key? key,
    this.selectedDate,
    this.minDate,
    this.maxDate,
    this.onChange,
    this.focusedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CalendarProvider(
            selectedDate,
            focusedDate,
            minDate,
            maxDate,
          ),
        ),
      ],
      child: CalendarModule(
        onChange: onChange,
      ),
    );
  }
}
