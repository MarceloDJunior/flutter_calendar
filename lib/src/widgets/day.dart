import 'package:calendar/src/utils/constants.dart';
import 'package:flutter/material.dart';

class Day extends StatelessWidget {
  final int day;
  final bool selected;
  final bool unfocused;
  final bool disabled;
  final Function onClick;

  Day({
    Key? key,
    required this.day,
    this.selected = false,
    this.unfocused = false,
    this.disabled = false,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? textColor = selected ? Colors.white : null;

    return InkWell(
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
                          selected ? FontWeight.normal : FontWeight.w300,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: selected ? COLOR_PRIMARY : Colors.transparent,
                borderRadius:
                    BorderRadius.circular(MediaQuery.of(context).size.width),
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        if (!disabled) {
          onClick();
        }
      },
    );
  }
}
