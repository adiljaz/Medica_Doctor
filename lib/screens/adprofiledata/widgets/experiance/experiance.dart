import 'package:flutter/cupertino.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:media_doctor/widgets/profiletexfield/profiletetfield.dart';

class Experiance extends StatelessWidget {
  const Experiance({
    super.key,
    required TextEditingController yearofexpeianceController,
  }) : _yearofexpeianceController = yearofexpeianceController;

  final TextEditingController _yearofexpeianceController;

  @override
  Widget build(BuildContext context) {
    return ProfileTextFormField(
        keyboardtype: TextInputType.number,
        fonrmtype: 'Year of Experiance',
        formColor: Colormanager.whiteContainer,
        textcolor: Colormanager.grayText,
        controller: _yearofexpeianceController,
        value: (value) {
          if (value == null || value.isEmpty) {
            return 'Add Year of Experiance';
          }
    
          return null;
        });
  }
}
