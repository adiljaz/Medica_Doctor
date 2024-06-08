import 'package:flutter/cupertino.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:media_doctor/widgets/profiletexfield/profiletetfield.dart';

class HospitalName extends StatelessWidget {
  const HospitalName({
    super.key,
    required TextEditingController hospitalnameController,
  }) : _hospitalnameController = hospitalnameController;

  final TextEditingController _hospitalnameController;

  @override
  Widget build(BuildContext context) {
    return ProfileTextFormField(
        keyboardtype: TextInputType.name,
        fonrmtype: ' Hospital Name ',
        formColor: Colormanager.whiteContainer,
        textcolor: Colormanager.grayText,
        controller: _hospitalnameController,
        value: (value) {
          if (value == null || value.isEmpty) {
            return 'Add Hospital name';
          }
    
          return null;
        });
  }
}

