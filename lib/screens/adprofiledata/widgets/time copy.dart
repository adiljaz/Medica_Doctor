import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';

// ignore: must_be_immutable
class AvailableTime extends StatelessWidget {
  
  final TextEditingController controller;
  final String labeltext;
  void Function()? onTap;

   AvailableTime({super.key,  required this.controller,required this.labeltext,required this.onTap});

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = FocusNode();
    return TextFormField(
      
    
      onTap: onTap,
       focusNode: myFocusNode,        
      autovalidateMode: AutovalidateMode.onUserInteraction,
     
      controller: controller,
      
      decoration: InputDecoration(
        labelStyle: GoogleFonts.poppins(textStyle:TextStyle(fontWeight: FontWeight.w600)),
           labelText:labeltext ,
         focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colormanager.blueContainer,
              width: 1,
            ),
          ),
            enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 220, 219, 219),
              width: 1,
            ),
          ),

            errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.red, 
              width: 1,
            ),
          ),

           focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),


        
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder()),
    );
  }
}
