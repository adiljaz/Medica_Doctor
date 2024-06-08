import 'package:flutter/cupertino.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:media_doctor/widgets/profiletexfield/profiletetfield.dart';

class About extends StatelessWidget {
  const About({
    super.key,
    required TextEditingController aboutnameController,
  }) : _aboutnameController = aboutnameController;

  final TextEditingController _aboutnameController;

  @override
  Widget build(BuildContext context) {
    return ProfileTextFormField(
        minline: 10,
        maxline: 1,
        keyboardtype: TextInputType.name,
        fonrmtype: ' About',
        formColor: Colormanager.whiteContainer,
        textcolor: Colormanager.grayText,
        controller: _aboutnameController,
        value: (value) {
          if (value == null || value.isEmpty) {
            return 'Add About';
          }
    
          return null;
        });
  }
}