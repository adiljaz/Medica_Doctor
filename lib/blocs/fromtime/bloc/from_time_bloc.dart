import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_doctor/blocs/fromtime/bloc/from_time_event.dart';
import 'package:media_doctor/blocs/fromtime/bloc/from_time_state.dart';

class FromTimeBloc extends Bloc<FromTimeEvent, FromTimeState> {
  FromTimeBloc() : super(FromTimeInitial()) {
    on<FromTimeSelected>((event, emit) {
      emit(FromTimeUpdated(event.time));
    });
  }
}
