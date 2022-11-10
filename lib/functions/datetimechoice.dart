import 'package:flutter/material.dart';
Future<DateTime?> pickDate(BuildContext context)=>showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime.now(),
  lastDate: DateTime.now().add(Duration(days: 30)),
);

Future<TimeOfDay?> pickTime(BuildContext context)=>showTimePicker(
  context: context,
  initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
);