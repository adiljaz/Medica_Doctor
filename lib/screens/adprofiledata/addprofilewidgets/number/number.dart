import 'package:flutter/cupertino.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:media_doctor/widgets/profiletexfield/profiletetfield.dart';

class MobileNumber extends StatelessWidget {
  const MobileNumber({
    super.key,
    required TextEditingController mbobilecontroller,
  }) : _mbobilecontroller = mbobilecontroller;

  final TextEditingController _mbobilecontroller;

  @override
  Widget build(BuildContext context) {
    return ProfileTextFormField(
        keyboardtype: TextInputType.number,
        fonrmtype: 'Mobile Number ',
        formColor: Colormanager.whiteContainer,
        textcolor: Colormanager.grayText,
        controller: _mbobilecontroller,
        value: (value) {
          if (value == null || value.isEmpty) {
            return 'Mobile Number ';
          }
    
          return null;
        });
  }
}
