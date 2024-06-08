// time_state.dart
import 'package:flutter/material.dart';

abstract class FromTimeState {}

class FromTimeInitial extends FromTimeState {
  final TimeOfDay time;

  FromTimeInitial() : time = TimeOfDay.now();
}

class FromTimeUpdated extends FromTimeState {
  final TimeOfDay time;

  FromTimeUpdated(this.time);
}
