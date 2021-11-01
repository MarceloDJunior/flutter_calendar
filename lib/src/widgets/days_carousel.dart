import 'package:calendar/src/providers/calendar_provider.dart';
import 'package:calendar/src/utils/datetime_utils.dart';
import 'package:calendar/src/widgets/days.dart';
import 'package:calendar/src/widgets/week_days.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DaysCarousel extends StatefulWidget {
  final DateTime visibleDate;
  final Function? onChange;

  DaysCarousel({
    Key? key,
    required this.visibleDate,
    this.onChange,
  }) : super(key: key);

  @override
  _DaysCarouselState createState() => _DaysCarouselState();
}

class _DaysCarouselState extends State<DaysCarousel>
    with SingleTickerProviderStateMixin {
  late DateTime currentVisibleDate;
  bool didDismiss = false;

  late AnimationController _animationController;
  late Animation<Offset> _animation;

  void animateNextMonth() {
    if (didDismiss) {
      _animationController.reset();
      _animation = Tween<Offset>(
        end: Offset.zero,
        begin: Offset(1.5, 0),
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.linearToEaseOut,
      ));
      _animationController.forward();
      setState(() => didDismiss = false);
    }
  }

  void animatePreviousMonth() {
    if (didDismiss) {
      _animationController.reset();
      _animation = Tween<Offset>(
        end: Offset.zero,
        begin: Offset(-1.5, 0),
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.linearToEaseOut,
      ));
      _animationController.forward();
      setState(() => didDismiss = false);
    }
  }

  @override
  void initState() {
    super.initState();
    currentVisibleDate = widget.visibleDate;
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<Offset>(
      end: Offset.zero,
      begin: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linearToEaseOut,
    ));
  }

  @override
  void didUpdateWidget(DaysCarousel oldWidget) {
    if (oldWidget.visibleDate != widget.visibleDate) {
      setState(() {
        currentVisibleDate = widget.visibleDate;
      });
      if (widget.visibleDate.isAfter(oldWidget.visibleDate)) {
        animateNextMonth();
        return;
      }
      animatePreviousMonth();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> onDismiss(DismissDirection direction) {
      setState(() => didDismiss = true);
      late DateTime nextDate;
      if (direction == DismissDirection.endToStart) {
        nextDate = DateTime(
          DateTimeUtils.getNextMonthYear(currentVisibleDate),
          DateTimeUtils.getNextMonth(currentVisibleDate),
          currentVisibleDate.day,
        );
      } else {
        nextDate = DateTime(
          DateTimeUtils.getPreviousMonthYear(currentVisibleDate),
          DateTimeUtils.getPreviousMonth(currentVisibleDate),
          currentVisibleDate.day,
        );
      }
      Provider.of<CalendarProvider>(context, listen: false)
          .setVisibleDate(nextDate);
      return Future.value(false);
    }

    return SlideTransition(
      position: _animation,
      child: Dismissible(
        key: Key(currentVisibleDate.toString()),
        confirmDismiss: onDismiss,
        child: Column(
          children: [
            WeekDays(),
            Days(
              visibleDate: currentVisibleDate,
              onChange: widget.onChange,
            ),
          ],
        ),
      ),
    );
  }
}
