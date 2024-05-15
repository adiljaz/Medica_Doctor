import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';

class Weeklydays extends StatelessWidget {
  final Color color;
  final String day;

  Weeklydays({super.key, required this.color, required this.day});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: color,
      child: Text(
        day,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontWeight: FontWeight.w600, color: Colormanager.scaffold)),
      ),
    );
  }
}
