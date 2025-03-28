import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_journal_flutter_2/components/my_number_slider.dart';
import 'package:gap/gap.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:intl/intl.dart';
import 'package:stack/stack.dart' as stack_lib;

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

  stack_lib.Stack<String> lock = stack_lib.Stack<String>();

  int test = 0;

  @override
  void initState() {
    pace = Pace(minutes: 4, speed: 15);
    pace.createControllers();

    distance = Distance(meters: 1500);
    distance.createControllers();

    time = Time(minutes: 6);
    time.createControllers();

    pace.peaceMinutesController.addListener(() {});

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    lock.push("Pace");
    lock.push("Distance");
    lock.push("Time");
    final NumberFormat formatter = NumberFormat("00");
    final TextStyle variableStyle = TextStyle(fontSize: 70, color: Theme.of(context).colorScheme.primary, height: 1);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  lock.top() == "Pace" ? Container() : MyLockIcon(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
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
                      Positioned(
                        child: Text("'", style: variableStyle),
                      ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("${pace.speed} km/h", style: extraDataStyle),
                  ),
                ],
              ),
              Gap(40),

              //==Distance==
              Row(
                children: [
                  Text("Distance", style: nameStyle),
                  lock.top() == "Distance" ? Container() : MyLockIcon(),
                ],
              ),
              Row(
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
              Gap(40),

              //==Time==
              Row(
                children: [
                  Text("Time", style: nameStyle),
                  lock.top() == "Time" ? Container() : MyLockIcon(),
                ],
              ),
              Row(
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
              Text(pace.toString()),
              Text(distance.toString()),
              Text(time.toString()),
              Text(test.toString()),
              Text(lock.top()),
            ],
          ),
        ),
      ),
    );
  }
}

class MyLockIcon extends StatelessWidget {
  const MyLockIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Icon(
        CupertinoIcons.lock_fill,
        size: 20,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
      ),
    );
  }
}
