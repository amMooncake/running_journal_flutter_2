import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class MyNumberSlider extends StatefulWidget {
  final int startPosition;
  final FixedExtentScrollController controller;
  final List<WheelChoice> choices;
  final Function onChangedFunction;
  final int noOfPos;
  const MyNumberSlider({
    super.key,
    required this.startPosition,
    required this.choices,
    required this.onChangedFunction,
    required this.noOfPos,
    required this.controller,
  });

  @override
  State<MyNumberSlider> createState() => _MyNumberSliderState();
}

class _MyNumberSliderState extends State<MyNumberSlider> {
  @override
  Widget build(BuildContext context) {
    final TextStyle variableStyle = TextStyle(fontSize: 46, color: Theme.of(context).colorScheme.primary, height: 1);
    return SizedBox(
      height: 100,
      width: widget.noOfPos * 46,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.white, Colors.white, Colors.transparent],
            stops: [0.0, 0.2, 0.8, 1.0],
          ).createShader(bounds);
        },
        child: WheelChooser.choices(
          controller: widget.controller,
          selectTextStyle: variableStyle,
          unSelectTextStyle: variableStyle.copyWith(color: Theme.of(context).colorScheme.secondary),
          itemSize: 60,
          startPosition: null,
          choices: widget.choices,
          onChoiceChanged: (value) {
            widget.onChangedFunction(value);
          },
        ),
      ),
    );
  }
}
