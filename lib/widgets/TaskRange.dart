import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shammo/shammo.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_app/widgets/customwidgets.dart';

class TaskRange extends StatelessWidget {
  const TaskRange(
      {super.key,
      required this.changeRange,
      required this.range,
      required this.taskScrollDirection});
  final void Function(String) changeRange;
  final String range;
  final ScrollDirection? taskScrollDirection;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      child: Column(
        children: [
          SizedBox(
            width: width(context),
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final r in ['Day', 'Week', 'Month', 'All'])
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Button(
                      color: range == r ? null : Colors.transparent,
                      textStyle: TextStyle(
                          color: range == r ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold),
                      onPressed: () {
                        changeRange(r);
                      },
                      text: r,
                    ),
                  )
              ],
            ),
          ),
          if (range == 'Month' &&
              (taskScrollDirection == ScrollDirection.forward ||
                  taskScrollDirection == null))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.range,
                enablePastDates: false,
              ),
            )
        ],
      ),
    );
  }
}
