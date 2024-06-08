import 'package:flutter_bloc/flutter_bloc.dart';
import 'weekday_event.dart';
import 'weekday_state.dart';

class WeekdayBloc extends Bloc<WeekdayEvent, WeekdayState> {
  WeekdayBloc() : super(WeekdayInitial()) {
    on<WeekdayToggled>((event, emit) {
      if (state is WeekdayInitial || state is WeekdayUpdated) {
        final updatedDays = List<bool>.from((state as dynamic).availableDays);
        final index = event.day % 7;
        updatedDays[index] = !updatedDays[index];
        emit(WeekdayUpdated(updatedDays));
      }
    });
  }
}
