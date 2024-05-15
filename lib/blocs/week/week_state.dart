part of 'week_bloc.dart';

@immutable
sealed class WeekState {}

final class WeekInitial extends WeekState {}
final class Sundaychange extends WeekState{}
final class SundaychangeBack extends WeekState{}
