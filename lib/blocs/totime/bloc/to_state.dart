// time_state.dart
import 'package:flutter/material.dart';

abstract class ToTimeState {}

class ToTimeInitial extends ToTimeState {
  final TimeOfDay time;

  ToTimeInitial() : time = TimeOfDay.now();
}

class ToTimeUpdated extends ToTimeState {
  final TimeOfDay time;

  ToTimeUpdated(this.time);
}
