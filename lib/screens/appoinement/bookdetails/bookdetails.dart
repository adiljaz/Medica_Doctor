import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_doctor/screens/appoinement/bookdetails/widget/userwidget.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';

class UserBooking extends StatelessWidget {
  const UserBooking(
      {required this.name,
      required this.age,
      required this.disease,
      required this.problem,
      required this.selectedday,
      required this.timeslote,
      required this.image});

  final String name;
  final String age;
  final String disease;
  final String problem;
  final String selectedday;
  final String timeslote;

  final String image;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuer = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: Colormanager.scaffold,
        appBar: AppBar(
          backgroundColor: Colormanager.scaffold,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Today Booking',
            style:
                GoogleFonts.dongle(fontWeight: FontWeight.bold, fontSize: 33),
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(77, 4, 188, 255),
            ),
            width: mediaQuer.size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: mediaQuer.size.height * 0.03,
                ),
                Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        image,
                        height: mediaQuer.size.height * 0.30,
                        width: mediaQuer.size.width * 0.75,
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height: mediaQuer.size.height * 0.015,
                ),
                BookedUserWidget(
                  type: 'Name:-',
                  item: name,
                ),
                SizedBox(
                  height: mediaQuer.size.height * 0.015,
                ),
                BookedUserWidget(
                  type: 'Age:-',
                  item: age,
                ),
                SizedBox(
                  height: mediaQuer.size.height * 0.015,
                ),
                BookedUserWidget(
                  type: 'Date:-',
                  item: selectedday,
                ),
                SizedBox(
                  height: mediaQuer.size.height * 0.015,
                ),
                BookedUserWidget(
                  type: 'time:-',
                  item: timeslote,
                ),
                SizedBox(
                  height: mediaQuer.size.height * 0.015,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colormanager.whiteContainer,
                          borderRadius: BorderRadius.circular(4)),
                      width: mediaQuer.size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' problem :- ${problem}',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQuer.size.height * 0.04,
                ),
              ],
            ),
          ),
        )));
  }
}
