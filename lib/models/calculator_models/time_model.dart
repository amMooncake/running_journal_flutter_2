class Time {
  int hours;
  int minutes;
  int seconds;

  Time({
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
  });

  @override
  String toString() {
    return '$hours:$minutes:$seconds';
  }
}
