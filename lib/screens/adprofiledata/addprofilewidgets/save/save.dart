import 'package:flutter/cupertino.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';

class Save extends StatelessWidget {
  const Save({
    super.key,
    required this.mediaquery,
  });

  final MediaQueryData mediaquery;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colormanager.blueContainer,
            borderRadius: BorderRadius.circular(10)),
        height: mediaquery.size.width * 0.14,
        width: mediaquery.size.height * 0.4,
        child: Center(
          child: Text(
            'Save',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colormanager.whiteText),
          ),
        ),
      ),
    );
  }
}
