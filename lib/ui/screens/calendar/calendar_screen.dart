import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});
  DateTime _date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.tr("Calendar")),
        ),
        body: CalendarDatePicker(
            initialDate: _date,
            firstDate: DateTime(2000),
            lastDate: DateTime(2050),
            onDateChanged: (newDate) {
              _date = newDate;
            }),
      ),
    );
  }
}
