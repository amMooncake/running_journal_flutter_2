import 'package:flutter/material.dart';
import 'calculator_models.dart';

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

  void calculateTime(Pace pace, Distance distance) {
    if ((pace.minutes == 0 && pace.seconds == 0) || (distance.meters == 0)) {}
    int totalSeconds = ((pace.minutes * 60 + pace.seconds) * (distance.meters / 1000)).toInt();
    hours = totalSeconds ~/ 3600;
    totalSeconds = totalSeconds % 3600;
    minutes = totalSeconds ~/ 60;
    seconds = totalSeconds % 60;
    timeHoursController.animateToItem(hours, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
    timeMinutesController.animateToItem(minutes, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
    timeSecondsController.animateToItem(seconds, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

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
