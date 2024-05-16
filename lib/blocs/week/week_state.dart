part of 'week_bloc.dart';

@immutable
sealed class WeekState {}

final class WeekInitial extends WeekState {}

final class Sundaychange extends WeekState {}

final class SundaychangeBack extends WeekState {}

final class Mondychange extends WeekState {}

final class MondaychangeBack extends WeekState {}

final class Tuesdaychange extends WeekState {}

final class TuesdaychangeBack extends WeekState {}

final class Wednesdaychange extends WeekState {}

final class WednesdaychangeBack extends WeekState {}

final class Thursdaychange extends WeekState {}

final class ThursdaychangeBack extends WeekState {}

final class Fridaychange extends WeekState {}

final class FridaychangeBack extends WeekState {}

final class Saturdaychange extends WeekState {}

final class SaturdaychangeBack extends WeekState {}
