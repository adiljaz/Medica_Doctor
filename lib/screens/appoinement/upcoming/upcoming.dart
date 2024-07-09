import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:media_doctor/screens/appoinement/bookdetails/bookdetails.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:page_transition/page_transition.dart';

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final doctor = FirebaseFirestore.instance.collection('doctor');
    final id = _auth.currentUser!.uid;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder(
        stream: doctor.doc(id).collection('dailyBookings').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No upcoming appointments'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final appointment = snapshot.data!.docs[index];
              return _buildAppointmentCard(context, appointment, mediaQuery);
            },
          );
        },
      ),
    );
  }

  Widget _buildAppointmentCard(BuildContext context,
      DocumentSnapshot appointment, MediaQueryData mediaQuery) {
    final name = appointment['name'] ?? 'N/A';
    final age = appointment['age'] ?? 'N/A';
    final gender = appointment['gender'] ?? 'N/A';
    final disease = appointment['disease'] ?? 'N/A';
    final selectedDay = appointment['selectedDay'] ?? 'N/A';
    final selectedTimeSlot = appointment['selectedTimeSlot'] ?? 'N/A';
    final image = appointment['image'] ?? '';

    return Card(
      color: Colormanager.whiteContainer,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _navigateToDetails(context, appointment),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: mediaQuery.size.width * 0.3,
                    height: mediaQuery.size.height * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  SizedBox(
                    width: mediaQuery.size.width * 0.47,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          width: mediaQuery.size.width * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: Colormanager.blueicon, width: 1.5),
                          ),
                          child: Center(
                            child: Text(
                              'Upcoming',
                              style: GoogleFonts.poppins(
                                color: Colormanager.blueicon,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '$age years old • $gender',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 16, color: Colors.grey[600]),
                            SizedBox(width: 4),
                            Text(
                              _formatDate(selectedDay),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                size: 16, color: Colors.grey[600]),
                            SizedBox(width: 4),
                            Text(
                              selectedTimeSlot,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _showCancellationConfirmation(context, appointment),
                    child: Container(
                      width: mediaQuery.size.width * 0.4,
                      height: mediaQuery.size.height * 0.05,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colormanager.blueContainer),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel Appointment',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colormanager.blueContainer,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: mediaQuery.size.width * 0.4,
                    height: mediaQuery.size.height * 0.05,
                    decoration: BoxDecoration(
                      color: Colormanager.blueContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCancellationConfirmation(BuildContext context, DocumentSnapshot appointment) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Cancel Appointment',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Are you sure you want to cancel this appointment?',
                style: GoogleFonts.poppins(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('  Back  ',),
                    style: ElevatedButton.styleFrom(
                      
                      backgroundColor:  Colors.grey, 
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _cancelAppointment(context, appointment);
                    },
                    child: Text('Yes, Cancel',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                    backgroundColor:  Colormanager.blueContainer,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _cancelAppointment(
      BuildContext context, DocumentSnapshot appointment) async {
    final doctorId = FirebaseAuth.instance.currentUser!.uid;
    final appointmentId = appointment.id;
 
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();

      DocumentReference doctorBookingRef = FirebaseFirestore.instance
          .collection('doctor')
          .doc(doctorId)
          .collection('dailyBookings')
          .doc(appointmentId);

      DocumentReference canceledRef = FirebaseFirestore.instance
          .collection('userbooking')  
          .doc(doctorId)
          .collection('canceledAppointments')
          .doc(appointmentId);

      batch.delete(doctorBookingRef);

      Map<String, dynamic> canceledAppointmentData = {
        ...appointment.data() as Map<String, dynamic>,
        'canceledAt': FieldValue.serverTimestamp(),
        'doctorId': doctorId,
      };

      canceledAppointmentData.remove('userId');
      canceledAppointmentData.remove('uid');

      batch.set(canceledRef, canceledAppointmentData);

      await batch.commit();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Appointment canceled successfully')), 
      );
    } catch (error) {
      print('Error canceling appointment: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to cancel appointment. Please try again.')),
      );
    }
  }

  void _navigateToDetails(BuildContext context, DocumentSnapshot appointment) {
    Navigator.of(context).push(
      PageTransition(
        child: UserBooking(
          image: appointment['image'] ?? '',
          age: appointment['age'] ?? '',
          disease: appointment['disease'] ?? '',
          name: appointment['name'] ?? '',
          problem: appointment['problem'] ?? '',
          selectedday: appointment['selectedDay'] ?? '',
          timeslote: appointment['selectedTimeSlot'] ?? '',
        ),
        type: PageTransitionType.fade,
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM d, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  } 
} 