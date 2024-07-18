import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_doctor/screens/appoinement/canceled/canceled.dart';
import 'package:media_doctor/screens/appoinement/completed/completed.dart';
import 'package:media_doctor/screens/appoinement/upcoming/upcoming.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colormanager.scaffold,

        appBar: AppBar(
          leading: Image.asset(
            'assets/images/logo.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          title: Text(
            'My Appointment',
            style:
                GoogleFonts.dongle(fontWeight: FontWeight.bold, fontSize: 33),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelStyle:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13),

            padding: EdgeInsets.only(left: 15, right: 15),
            // indicator: ,
            dividerHeight: 2.5,
            indicatorColor: Colormanager.blueicon,
            indicatorSize: TabBarIndicatorSize.tab,

            tabs: [
                Tab(text: 'Upcoming'), 
              Tab(
                text: 'Completed',
              ),
              Tab(
                text: 'Canceled  ',
              ),
            
            ],
          ), 
        ),
        body: TabBarView( 
          children: [

             UpcomingAppointments(),
 
            CompletedAppointments(),  
           
            CanceledAppointments(),
          ],
        ),
      ),
    );
  }
}





