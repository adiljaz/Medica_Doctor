import 'package:bloc/bloc.dart';
import 'package:media_doctor/blocs/dateofbirth/bloc/date_of_birth_event.dart';
import 'package:media_doctor/blocs/dateofbirth/bloc/date_of_birth_state.dart';


class DateOfBirthBloc extends Bloc<DateOfBirthEvent, DateOfBirthState> {
  DateOfBirthBloc() : super(DateOfBirthInitial()) {
    on<DateOfBirthSelected>((event, emit) {
      emit(DateOfBirthSelectedState(
          event.selectedDate.toString().split(" ")[0]));
    });
  }
}
