import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_journal_flutter_2/components/my_number_slider.dart';
import 'package:gap/gap.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:intl/intl.dart';

import '../models/calculator_models/calculator_models.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  final Peace peace = Peace(minutes: 4, seconds: 0, speed: 15);
  final Distance distance = Distance(meters: 1500);
  final Time time = Time(minutes: 6);

  @override
  Widget build(BuildContext context) {
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
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyNumberSlider(
                        noOfPos: 2,
                        startPosition: peace.minutes,
                        choices: List.generate(60, (index) => WheelChoice(value: index, title: formatter.format(index))),
                        onChangedFunction: (value) {
                          peace.minutes = value;
                          peace.calculateSpeed();
                          setState(() {});
                        },
                      ),
                      Positioned(
                        child: Text("'", style: variableStyle),
                      ),
                      MyNumberSlider(
                        noOfPos: 2,
                        startPosition: peace.seconds,
                        choices: List.generate(60, (index) => WheelChoice(value: index, title: formatter.format(index))),
                        onChangedFunction: (value) {
                          peace.seconds = value;
                          peace.calculateSpeed();
                          setState(() {});
                        },
                      ),
                      Text("\"", style: variableStyle),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("${peace.speed} km/h", style: extraDataStyle),
                  ),
                ],
              ),
              Gap(40),

              //==Distance==
              Text("Distance", style: nameStyle),
              Row(
                children: [
                  MyNumberSlider(
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
                  Row(
                    children: [
                      MyNumberSlider(
                          startPosition: time.hours,
                          choices: List.generate(60, (index) => WheelChoice(value: index, title: formatter.format(index))),
                          onChangedFunction: (value) {
                            time.hours = value;
                            setState(() {});
                          },
                          noOfPos: 2),
                      Text(':', style: variableStyle),
                      MyNumberSlider(
                          startPosition: time.minutes,
                          choices: List.generate(60, (index) => WheelChoice(value: index, title: formatter.format(index))),
                          onChangedFunction: (value) {
                            time.minutes = value;
                            setState(() {});
                          },
                          noOfPos: 2),
                      Text(':', style: variableStyle),
                      MyNumberSlider(
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
              Text(peace.toString()),
              Text('${distance.toString()}'),
              Text('${time.toString()}'),
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
