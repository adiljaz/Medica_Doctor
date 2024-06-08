// weekday_event.dart
abstract class WeekdayEvent {}

class WeekdayToggled extends WeekdayEvent {
  final int day;

  WeekdayToggled(this.day);
}
