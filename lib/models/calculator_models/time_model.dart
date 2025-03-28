import 'package:flutter/material.dart';

class Time {
  int hours;
  int minutes;
  int seconds;
  late FixedExtentScrollController timeHoursController;
  late FixedExtentScrollController timeMinutesController;
  late FixedExtentScrollController timeSecondsController;

  Time({
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
  });

  void createControllers() {
    timeHoursController = FixedExtentScrollController(initialItem: hours);
    timeMinutesController = FixedExtentScrollController(initialItem: minutes);
    timeSecondsController = FixedExtentScrollController(initialItem: seconds);
  }

  @override
  String toString() {
    return '$hours:$minutes:$seconds';
  }
}
