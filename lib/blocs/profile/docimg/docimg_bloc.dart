import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'docimg_event.dart';
part 'docimg_state.dart';

class DocimgBloc extends Bloc<DocimgEvent, DocimgState> {
  DocimgBloc() : super(DocimgInitial()) {
    on<DocchageEvent>((event, emit)async {
      // TODO: implement event handler
      emit(DocSelectedState(docimageUrl: event.imageUrl));
    });
  }
}



