// weekday_state.dart
abstract class WeekdayState {}

class WeekdayInitial extends WeekdayState {
  final List<bool> availableDays;

  WeekdayInitial() : availableDays = List.filled(7, false);
}

class WeekdayUpdated extends WeekdayState {
  final List<bool> availableDays;

  WeekdayUpdated(this.availableDays);
}
