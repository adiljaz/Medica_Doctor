// time_event.dart
import 'package:flutter/material.dart';

abstract class ToTimeEvent {}

class ToTimeSelected extends ToTimeEvent {
  final TimeOfDay time;

  ToTimeSelected(this.time);
}
