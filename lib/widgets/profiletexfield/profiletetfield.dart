
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';

class ProfileTextFormField extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  ProfileTextFormField({
    required this.fonrmtype,
    required this.formColor,
    required this.textcolor,
    required this.controller,
    required this.value,
    required this.keyboardtype, 
    this.icons,
    this.suficon,
  });

  final FormFieldValidator<String> value;
  final String fonrmtype;
  final Color formColor;
  final Icon? icons;
  final Icon? suficon;
  final Color textcolor;
  final TextEditingController controller;

  final TextInputType keyboardtype;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        
        keyboardType: keyboardtype,
                autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: value,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icons,
          suffixIcon: suficon,
          labelText: fonrmtype,
          labelStyle: TextStyle(
            color: textcolor,
            fontWeight: FontWeight.w400,
          ),
          fillColor: formColor,
          filled: true,
          contentPadding:  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              
              color: Theme.of(context).primaryColor, // Use theme color for focused border
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            // Define border style for validation error
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.red, // Red border for validation error
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            // Define border style for focused validation error
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colormanager.blueContainer, // Red border for focused validation error
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
