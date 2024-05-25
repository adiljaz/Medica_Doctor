import 'package:flutter/cupertino.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:media_doctor/widgets/profiletexfield/profiletetfield.dart';

class name extends StatelessWidget {
  const name({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return ProfileTextFormField(
        keyboardtype: TextInputType.name,
        fonrmtype: 'Name ',
        formColor: Colormanager.whiteContainer,
        textcolor: Colormanager.grayText,
        controller: _nameController,
        value: (value) {
          if (value == null || value.isEmpty) {
            return 'Add Name ';
          }
    
          return null;
        });
  }
}