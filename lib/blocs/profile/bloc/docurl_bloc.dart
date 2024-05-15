import 'package:bloc/bloc.dart';
import 'package:media_doctor/blocs/profile/ImageAdding/image_adding_bloc.dart';
import 'package:meta/meta.dart';

part 'docurl_event.dart';
part 'docurl_state.dart';

class DocurlBloc extends Bloc<DocurlEvent, DocurlState> {
  DocurlBloc() : super(DocurlInitial()) {
    on<DocAddedEvent>((event, emit) {
      emit(DocSelectedState(imageUrl: event.imageUrl));
    });
  }
}
