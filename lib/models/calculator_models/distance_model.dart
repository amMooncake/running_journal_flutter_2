import 'package:flutter/material.dart';
import 'calculator_models.dart';

class Distance {
  int meters;
  late FixedExtentScrollController distanceController;

  Distance({
    required this.meters,
  });

  void calculateDistance(Pace pace, Time time) {
    if ((pace.minutes == 0 && pace.seconds == 0) || (time.hours == 0 && time.minutes == 0 && time.seconds == 0)) {
      meters = 0;
      distanceController.animateToItem(0, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
      return;
    }
    meters = ((time.hours * 3600 + time.minutes * 60 + time.seconds) / ((pace.minutes * 60 + pace.seconds) / (1000))).toInt();
    distanceController.animateToItem(meters ~/ 10, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  void createControllers() {
    distanceController = FixedExtentScrollController(initialItem: meters ~/ 10);
  }

  @override
  String toString() {
    return "$meters";
  }
}
