part of 'week_bloc.dart';

@immutable
sealed class WeekEvent {}

class SundayClick extends WeekEvent {
  final bool? sunday;

  SundayClick({required this.sunday});
}

class MondayClick extends WeekEvent {
  final bool? monday;

  MondayClick({required this.monday});
}

class TuesdayClick extends WeekEvent {
  final bool? tuesday;

  TuesdayClick({required this.tuesday});
}

class WednesdayClick extends WeekEvent {
  final bool? wednesday;

  WednesdayClick({required this.wednesday});
}

class ThursdayClick extends WeekEvent {
  final bool? thursday;

  ThursdayClick({required this.thursday});
}

class Fridayclick extends WeekEvent {
  final bool? friday;

  Fridayclick({required this.friday});
}

class Saturdayclik extends WeekEvent {
  final bool? saturday;

  Saturdayclik({required this.saturday});
}
