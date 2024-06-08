import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media_doctor/repository/repo.dart';
import 'package:meta/meta.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  GoogleAuthBloc() : super(GoogleAuthInitial()) {
    on<SigninEvent>(_sihningWithGoogle);
  }

  final AuthRepo authrepository = AuthRepo();

  Future<void> _sihningWithGoogle(
      SigninEvent event, Emitter<GoogleAuthState> emit) async {
    // final user = await _authRepo.sihningWithGoogle();

    emit(GoogleAuthPendingn());

    final doctor = await authrepository.signinWithGoogle();
    if (doctor != null) {
      final name = doctor.email?.split('@').first;
      FirebaseFirestore.instance.collection('doctor auth').doc(doctor.uid).set({
        'uid': doctor.uid,
        'email': doctor.email,
        'name': name,
      });
      emit(GoogleAuthsuccess());
    }
    emit(GoogleAuthError());
  }
}
