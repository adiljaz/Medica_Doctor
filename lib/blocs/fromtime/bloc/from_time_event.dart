// time_event.dart
import 'package:flutter/material.dart';

abstract class FromTimeEvent {}

class FromTimeSelected extends FromTimeEvent {
  final TimeOfDay time;

  FromTimeSelected(this.time);
}
