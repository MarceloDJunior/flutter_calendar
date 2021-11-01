import 'package:calendar/calendar.dart';
import 'package:flutter/material.dart';

class CalendarBottomSheet extends StatefulWidget {
  const CalendarBottomSheet({Key? key}) : super(key: key);

  @override
  _CalendarBottomSheetState createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: SizedBox(height: 40)),
                    const Expanded(
                      child: Text(
                        "Select a date",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          child: const Icon(Icons.close),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Calendar(
                selectedDate: DateTime(2021, 11, 11),
                minDate: DateTime.now(),
                onChange: (DateTime date) {
                  // ignore: avoid_print
                  print(date);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
