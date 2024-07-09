abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class DoctorAppointmentCancelled extends DoctorState {}

class DoctorError extends DoctorState {
  final String message;

  DoctorError(this.message);
}