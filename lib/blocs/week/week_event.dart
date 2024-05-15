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

class TuesdayClick extends WeekEvent{
  final bool ?tuesday;

  TuesdayClick({required this.tuesday});
}

class Saturdayclick extends WeekEvent {
  final bool? saturday;

  Saturdayclick({required this.saturday});
}

