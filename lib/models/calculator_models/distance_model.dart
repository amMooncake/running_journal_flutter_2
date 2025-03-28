import 'package:flutter/material.dart';

class Distance {
  int meters;
  late FixedExtentScrollController distanceController;

  Distance({
    required this.meters,
  });

  void createControllers() {
    distanceController = FixedExtentScrollController(initialItem: meters ~/ 10);
  }

  @override
  String toString() {
    return "$meters";
  }
}
