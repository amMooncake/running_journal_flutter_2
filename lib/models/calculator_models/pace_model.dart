import 'package:flutter/material.dart';
import 'calculator_models.dart';

class Pace {
  int minutes;
  int seconds;
  double speed;
  late FixedExtentScrollController peaceSecondsController;
  late FixedExtentScrollController peaceMinutesController;

  Pace({
    this.minutes = 0,
    this.seconds = 0,
    this.speed = 0,
  });

  void createControllers() {
    peaceMinutesController = FixedExtentScrollController(initialItem: minutes);
    peaceSecondsController = FixedExtentScrollController(initialItem: seconds);
  }

  void calculatePace(Time time, Distance distance) {
    if (((time.hours == 0) && (time.minutes == 0) && (time.seconds == 0)) || (distance.meters == 0)) {
      minutes = 0;
      seconds = 0;
      peaceMinutesController.animateToItem(0, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
      peaceSecondsController.animateToItem(0, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
      return;
    }
    seconds = (((time.hours * 3600 + time.minutes * 60 + time.seconds) / (distance.meters) * 1000)).toInt();
    minutes = seconds ~/ 60;
    seconds = seconds % 60;
    peaceMinutesController.animateToItem(minutes, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
    peaceSecondsController.animateToItem(seconds, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  void calculateSpeed() {
    if (seconds == 0 && minutes == 0) {
      speed = 0;
      return;
    }
    speed = double.parse((3600 / (minutes * 60 + seconds)).toStringAsFixed(2));
  }

  @override
  String toString() {
    return "$minutes:$seconds";
  }
}
