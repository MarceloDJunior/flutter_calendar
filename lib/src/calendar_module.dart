import 'package:calendar/src/providers/calendar_provider.dart';
import 'package:calendar/src/widgets/days_carousel.dart';
import 'package:flutter/material.dart';
import 'package:calendar/src/widgets/header.dart';
import 'package:provider/provider.dart';

class CalendarModule extends StatelessWidget {
  final Function? onChange;

  const CalendarModule({
    Key? key,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      child: Column(
        children: [
          Header(),
          DaysCarousel(
            visibleDate: Provider.of<CalendarProvider>(context).visibleDate,
            onChange: onChange,
          ),
        ],
      ),
    );
  }
}
