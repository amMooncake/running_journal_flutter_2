class Peace {
  int minutes;
  int seconds;
  double speed;

  Peace({required this.minutes, required this.seconds, required this.speed});

  void calculateSpeed() {
    speed = double.parse((3600 / (minutes * 60 + seconds)).toStringAsFixed(2));
  }

  @override
  String toString() {
    return "$minutes:$seconds";
  }
}
