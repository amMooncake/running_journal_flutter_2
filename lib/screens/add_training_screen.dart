import 'package:flutter/material.dart';

import '../components/wave_slider.dart';

class AddTrainingScreen extends StatefulWidget {
  const AddTrainingScreen({super.key});

  @override
  State<AddTrainingScreen> createState() => _AddTrainingScreenState();
}

class _AddTrainingScreenState extends State<AddTrainingScreen> {
  int _changingStart = 0;

  int _chargingEnd = 0;
  int _age = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.tertiary, Theme.of(context).colorScheme.surfaceBright],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              WaveSlider(
                onChanged: (double val) {
                  setState(() {
                    _chargingEnd = (val * 100).round();
                  });
                },
                onChangeStart: (double val) {
                  setState(() {
                    _changingStart = (val * 100).round();
                  });
                },
                onChangeEnd: (double val) {
                  setState(() {
                    _age = _age - _changingStart + _chargingEnd;
                    if (_age < 0) {
                      _age = 0;
                    }
                    _changingStart = 0;
                    _chargingEnd = 0;
                  });
                },
              ),
              SizedBox(height: 40),
              Text("${(_age - _changingStart + _chargingEnd) > 0 ? (_age - _changingStart + _chargingEnd) : 0}",
                  style: Theme.of(context).textTheme.bodyLarge),
              Text("$_changingStart", style: Theme.of(context).textTheme.bodyLarge),
              Text("$_chargingEnd", style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
