abstract class DoctorEvent {}

class CancelDoctorAppointment extends DoctorEvent {
  final String appointmentId;
  final String userId;

  CancelDoctorAppointment({required this.appointmentId, required this.userId});
}