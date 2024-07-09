import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:media_doctor/blocs/appoinement/appoinement_event.dart';
import 'package:media_doctor/blocs/appoinement/appoinement_state.dart';


class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DoctorBloc() : super(DoctorInitial()) {
    on<CancelDoctorAppointment>(_onCancelAppointment);
  }

  void _onCancelAppointment(CancelDoctorAppointment event, Emitter<DoctorState> emit) async {
    try {
      final doctorId = _auth.currentUser!.uid;
      final appointmentRef = _firestore.collection('doctor').doc(doctorId).collection('dailyBookings').doc(event.appointmentId);
      final appointmentSnapshot = await appointmentRef.get();

      if (appointmentSnapshot.exists) {
        final appointmentData = appointmentSnapshot.data() as Map<String, dynamic>;

        // Delete the appointment from doctor's dailyBookings
        await appointmentRef.delete();

        // Add to cancelled appointments collection
        await _firestore.collection('cancelledappointments').add({
          ...appointmentData,
          'doctorId': doctorId,
          'userId': event.userId,
          'cancelledAt': FieldValue.serverTimestamp(),
        });

        // Remove the booked time slot
        final selectedDay = appointmentData['selectedDay'];
        final selectedTimeSlot = appointmentData['selectedTimeSlot'];
        await _firestore.collection('doctor').doc(doctorId).collection('bookedSlots')
            .where('selectedDay', isEqualTo: selectedDay)
            .where('selectedTimeSlot', isEqualTo: selectedTimeSlot)
            .get()
            .then((snapshot) {
          for (var doc in snapshot.docs) {
            doc.reference.delete();
          }
        });

        emit(DoctorAppointmentCancelled());
      } else {
        emit(DoctorError('Appointment not found'));
      }
    } catch (e) {
      emit(DoctorError('Error cancelling appointment: $e'));
    }
  }
}