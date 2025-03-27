import 'package:flutter/material.dart';

String _zeroPad(int dateTimeValue) {
  if (dateTimeValue < 10) {
    return '0$dateTimeValue';
  }
  return dateTimeValue.toString();
}

String formatDate(DateTime dateTime) {
  final day = _zeroPad(dateTime.day);
  final month = _zeroPad(dateTime.month);
  final year = dateTime.year;

  return '$day.$month.$year';
}

String formatTime(TimeOfDay time) {
  final hour = _zeroPad(time.hour);
  final minute = _zeroPad(time.minute);

  return '$hour:$minute';
}

String formatDateTime(DateTime dateTime) {
  final date = formatDate(dateTime);
  final time = formatTime(TimeOfDay.fromDateTime(dateTime));

  return '$date $time';
}

String formatDateForChart(DateTime dateTime) {
  final day = _zeroPad(dateTime.day);
  final month = _zeroPad(dateTime.month);
  return '$day.$month';
}