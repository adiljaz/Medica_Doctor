import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'week_event.dart';
part 'week_state.dart';

class WeekBloc extends Bloc<WeekEvent, WeekState> {
  WeekBloc() : super(WeekInitial()) {
    on<SundayClick>((event, emit) {
      if(event.sunday!){

        emit(Sundaychange());
        print('treeeeeeeee');

      }else{
        emit(SundaychangeBack());

        print('falseeeeeeeeeeee');
      }
    });
  }
}
