import 'package:flutter/material.dart';

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

  void calculateSpeed() {
    speed = double.parse((3600 / (minutes * 60 + seconds)).toStringAsFixed(2));
  }

  @override
  String toString() {
    return "$minutes:$seconds";
  }
}
