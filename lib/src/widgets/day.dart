import 'package:calendar/src/utils/constants.dart';
import 'package:flutter/material.dart';

class Day extends StatelessWidget {
  final int day;
  final bool selected;
  final bool interval;
  final bool unfocused;
  final bool disabled;
  final bool startDate;
  final bool endDate;
  final Function onClick;

  Day({
    Key? key,
    required this.day,
    this.selected = false,
    this.interval = false,
    this.unfocused = false,
    this.disabled = false,
    this.startDate = false,
    this.endDate = false,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? textColor = selected ? Colors.white : null;

    BorderRadiusGeometry getContainerShape() {
      if (startDate) {
        return BorderRadius.only(
          topLeft: Radius.circular(MediaQuery.of(context).size.width),
          bottomLeft: Radius.circular(MediaQuery.of(context).size.width),
        );
      }
      if (endDate) {
        return BorderRadius.only(
          topRight: Radius.circular(MediaQuery.of(context).size.width),
          bottomRight: Radius.circular(MediaQuery.of(context).size.width),
        );
      }
      return BorderRadius.zero;
    }

    bool isSelected = selected || startDate || endDate;

    return InkWell(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Opacity(
            opacity: unfocused || disabled ? 0.4 : 1,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 68,
                  maxWidth: 68,
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.42,
                    heightFactor: 0.42,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        day.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontWeight:
                              isSelected ? FontWeight.normal : FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: selected ? COLOR_PRIMARY : Colors.transparent,
                    borderRadius: isSelected
                        ? BorderRadius.circular(
                            MediaQuery.of(context).size.width)
                        : BorderRadius.zero,
                  ),
                ),
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: interval || startDate || endDate
              ? COLOR_PRIMARY_LIGHT
              : Colors.transparent,
          borderRadius: getContainerShape(),
        ),
      ),
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width),
      ),
      onTap: () {
        if (!disabled) {
          onClick();
        }
      },
    );
  }
}
