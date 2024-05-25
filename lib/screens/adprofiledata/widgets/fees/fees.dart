import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:media_doctor/widgets/profiletexfield/profiletetfield.dart';

class Fees extends StatelessWidget {
  const Fees({
    super.key,
    required TextEditingController feescontroller,
  }) : _feescontroller = feescontroller;

  final TextEditingController _feescontroller;

  @override
  Widget build(BuildContext context) {
    return ProfileTextFormField(
        keyboardtype: TextInputType.number,
        fonrmtype: 'consultation fees',
        formColor: Colormanager.whiteContainer,
        textcolor: Colormanager.grayText,
        controller: _feescontroller,
        suficon: const Icon(
          Icons.currency_rupee_sharp,
          color: Colormanager.blackIcon,
        ),
        value: (value) {
          if (value == null || value.isEmpty) {
            return 'Add consultation fees';
          }
    
          return null;
        });
  }
}
