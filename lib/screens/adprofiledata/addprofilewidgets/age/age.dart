import 'package:flutter/cupertino.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:media_doctor/widgets/profiletexfield/profiletetfield.dart';

class Age extends StatelessWidget {
  const Age({
    super.key,
    required TextEditingController ageController,
  }) : _ageController = ageController;

  final TextEditingController _ageController;

  @override
  Widget build(BuildContext context) {
    return ProfileTextFormField(
        keyboardtype: TextInputType.number,
        fonrmtype: 'Age ',
        formColor: Colormanager.whiteContainer,
        textcolor: Colormanager.grayText,
        controller: _ageController,
        value: (value) {
          if (value == null || value.isEmpty) {
            return 'Add age ';
          }
    
          return null;
        });
  }
}

