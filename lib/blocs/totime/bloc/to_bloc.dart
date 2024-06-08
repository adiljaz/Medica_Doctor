import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_doctor/blocs/fromtime/bloc/from_time_event.dart';
import 'package:media_doctor/blocs/fromtime/bloc/from_time_state.dart';
import 'package:media_doctor/blocs/totime/bloc/to_event.dart';
import 'package:media_doctor/blocs/totime/bloc/to_state.dart';

class ToTimeBloc extends Bloc<ToTimeEvent, ToTimeState> {
  ToTimeBloc() : super(ToTimeInitial()) {
    on<ToTimeSelected>((event, emit) {
      emit(ToTimeUpdated(event.time));
    });
  }
}
