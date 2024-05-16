
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'week_event.dart';
part 'week_state.dart';

class WeekBloc extends Bloc<WeekEvent, WeekState> {
  WeekBloc() : super(WeekInitial()) {
    on<SundayClick>((event, emit) {
      if (event.sunday!) {
        emit(Sundaychange());
        print('sunday true');
      } else {

        emit(SundaychangeBack());
        print('sunday false');
      }
    });
    on<MondayClick>((event, emit) {
      if (event.monday!) {
        emit(Mondychange());

        print('monday true');
      } else {
        emit(MondaychangeBack());
        print('monday falsee');
      }
    });

    on<TuesdayClick>((event, emit) {
      if (event.tuesday!) {
        emit(Tuesdaychange());
      } else {
        emit(TuesdaychangeBack());
      }
    });

    on<WednesdayClick>((event, emit) {
      if (event.wednesday!) {
        emit(Wednesdaychange());
      } else {
        emit(Wednesdaychange());
      }
    });

    on<ThursdayClick>((event, emit) {
      if (event.thursday!) {
        emit(Thursdaychange());
      } else {
        emit(ThursdaychangeBack());
      }
    });

    on<Fridayclick>((event, emit) {
      if (event.friday!) {
        emit(Thursdaychange());
      } else {
        emit(ThursdaychangeBack());
      }
    });

    on<Saturdayclik>((event, emit) {
      if (event.saturday!) {
        emit(Thursdaychange());
      } else {
        emit(ThursdaychangeBack());
      }
    });
  }
}
