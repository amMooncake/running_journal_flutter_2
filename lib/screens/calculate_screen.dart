import 'package:flutter/material.dart';
import 'package:running_journal_flutter_2/components/my_number_slider.dart';
import 'package:gap/gap.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:intl/intl.dart';
import '../components/my_lock_icon.dart';

import '../models/calculator_models/calculator_models.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  late Pace pace;
  late Distance distance;
  late Time time;

  List<String> lock = [];

  int test = 0;

  void calculate() {
    switch (lock[0]) {
      case "Pace":
        pace.calculatePace(time, distance);
        break;
      case "Distance":
        distance.calculateDistance(pace, time);
        break;
      case "Time":
        time.calculateTime(pace, distance);
        break;
    }
    setState(() {});
  }

  void addListenerToController(FixedExtentScrollController controller, String lockName) {
    controller.addListener(() {
      calculate();
    });
  }

  @override
  void initState() {
    pace = Pace(minutes: 4, speed: 15);
    pace.createControllers();

    distance = Distance(meters: 1500);
    distance.createControllers();

    time = Time(minutes: 6);
    time.createControllers();

    addListenerToController(pace.peaceMinutesController, "Pace");
    addListenerToController(pace.peaceSecondsController, "Pace");
    addListenerToController(distance.distanceController, "Distance");
    addListenerToController(time.timeHoursController, "Time");
    addListenerToController(time.timeMinutesController, "Time");
    addListenerToController(time.timeSecondsController, "Time");

    lock.add("Pace");
    lock.add("Distance");
    lock.add("Time");

    super.initState();
  }

  @override
  void dispose() {
    pace.peaceMinutesController.dispose();
    pace.peaceSecondsController.dispose();
    distance.distanceController.dispose();
    time.timeHoursController.dispose();
    time.timeMinutesController.dispose();
    time.timeSecondsController.dispose();
    pace.peaceMinutesController.removeListener(() {});
    pace.peaceSecondsController.removeListener(() {});
    distance.distanceController.removeListener(() {});
    time.timeHoursController.removeListener(() {});
    time.timeMinutesController.removeListener(() {});
    time.timeSecondsController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat("00");
    final TextStyle variableStyle = TextStyle(fontSize: 60, color: Theme.of(context).colorScheme.primary, height: 1);
    final TextStyle nameStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1);
    final TextStyle extraDataStyle = TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.secondary, height: 1);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.onSecondary,
            Theme.of(context).colorScheme.surfaceBright,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              child: Text(
                "Calculator",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Gap(40),

            // ==Pace==
            Row(
              children: [
                Text("Pace", style: nameStyle),
                lock[0] == "Pace" ? Container() : MyLockIcon(),
              ],
            ),
            Listener(
              onPointerDown: (event) {
                print("Peace up");
                lock.remove('Pace');
                lock.add('Pace');
                setState(() {});
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Listener(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyNumberSlider(
                          controller: pace.peaceMinutesController,
                          noOfPos: 2,
                          startPosition: pace.minutes,
                          choices: List.generate(60, (index) => WheelChoice(value: index, title: formatter.format(index))),
                          onChangedFunction: (value) {
                            pace.minutes = value;
                            pace.calculateSpeed();
                            setState(() {});
                          },
                        ),
                        Text("'", style: variableStyle),
                        MyNumberSlider(
                          controller: pace.peaceSecondsController,
                          noOfPos: 2,
                          startPosition: pace.seconds,
                          choices: List.generate(60, (index) => WheelChoice(value: index, title: formatter.format(index))),
                          onChangedFunction: (value) {
                            pace.seconds = value;
                            pace.calculateSpeed();
                            setState(() {});
                          },
                        ),
                        Text("\"", style: variableStyle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("${pace.speed} km/h", style: extraDataStyle),
                  ),
                ],
              ),
            ),
            Gap(40),

            //==Distance==
            Row(
              children: [
                Text("Distance", style: nameStyle),
                lock[0] == "Distance" ? Container() : MyLockIcon(),
              ],
            ),
            Listener(
              onPointerDown: (event) {
                print("Distance up");
                lock.remove('Distance');
                lock.add('Distance');
                setState(() {});
              },
              child: Row(
                children: [
                  MyNumberSlider(
                    controller: distance.distanceController,
                    noOfPos: distance.meters < 10
                        ? 1
                        : distance.meters < 100
                            ? 2
                            : distance.meters < 1000
                                ? 3
                                : distance.meters < 10000
                                    ? 4
                                    : 5,
                    startPosition: (distance.meters / 10).toInt(),
                    choices: List.generate(10000, (index) => WheelChoice(value: index * 10, title: (index * 10).toString())),
                    onChangedFunction: (value) {
                      distance.meters = value;
                      setState(() {});
                    },
                  ),
                  Text("m", style: variableStyle),
                ],
              ),
            ),
            Gap(40),

            //==Time==
            Row(
              children: [
                Text("Time", style: nameStyle),
                lock[0] == "Time" ? Container() : MyLockIcon(),
              ],
            ),

            Listener(
              onPointerDown: (event) {
                print("Time up");
                lock.remove('Time');
                lock.add('Time');
                setState(() {});
              },
              child: Row(
                children: [
                  Row(
                    children: [
                      MyNumberSlider(
                          controller: time.timeHoursController,
                          startPosition: time.hours,
                          choices: List.generate(60, (index) => WheelChoice(value: index, title: formatter.format(index))),
                          onChangedFunction: (value) {
                            time.hours = value;
                            setState(() {});
                          },
                          noOfPos: 2),
                      Text(':', style: variableStyle),
                      MyNumberSlider(
                          controller: time.timeMinutesController,
                          startPosition: time.minutes,
                          choices: List.generate(60, (index) => WheelChoice(value: index, title: formatter.format(index))),
                          onChangedFunction: (value) {
                            time.minutes = value;
                            setState(() {});
                          },
                          noOfPos: 2),
                      Text(':', style: variableStyle),
                      MyNumberSlider(
                          controller: time.timeSecondsController,
                          startPosition: time.seconds,
                          choices: List.generate(60, (index) => WheelChoice(value: index, title: formatter.format(index))),
                          onChangedFunction: (value) {
                            time.seconds = value;
                            setState(() {});
                          },
                          noOfPos: 2),
                    ],
                  ),
                  Gap(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (time.hours > 0) Text("hours", style: extraDataStyle.copyWith(fontSize: 18)),
                      if (time.minutes > 0 || time.hours > 0) Text("min", style: extraDataStyle.copyWith(fontSize: 18)),
                      Text("seconds", style: extraDataStyle.copyWith(fontSize: 18)),
                    ],
                  )
                ],
              ),
            ),
            // Text(pace.toString()),
            // Text(distance.toString()),
            // Text(time.toString()),
            // Text(test.toString()),
            // Text(lock.toList().toString()),
          ]),
        ),
      ),
    );
  }
}
