import 'package:examples/date-picker/date_picker_calendar.dart';
import 'package:examples/date-range-picker/date_range_picker_calendar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    context: context,
                    builder: (ctx) => ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.9,
                      ),
                      child: const SingleChildScrollView(
                        child: DatePickerCalendar(),
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Open date picker calendar",
                  style: TextStyle(fontSize: 18, color: Colors.cyan),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    context: context,
                    builder: (ctx) => ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.9,
                      ),
                      child: const SingleChildScrollView(
                        child: DateRangePickerCalendar(),
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Open date range picker calendar",
                  style: TextStyle(fontSize: 18, color: Colors.cyan),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
