import 'package:bloc/bloc.dart';
import 'package:media_doctor/blocs/gender/bloc/gender_event.dart';
import 'package:media_doctor/blocs/gender/bloc/gender_state.dart';
import 'package:meta/meta.dart';

part 'department_event.dart';
part 'department_state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  DepartmentBloc() : super(DepartmentInitial()) {
    on<DepartmenetSelected>((event, emit) {

      emit(DepartmenetSelectedState(selectedDepartment: event.selecteDepartment));
   
    });
  }
}
