import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';

class BookedUserWidget extends StatelessWidget {
  const BookedUserWidget({required this.item, required this.type});

  final String item;
  final String type;

  @override
  Widget build(BuildContext context) {
     MediaQueryData mediaQuer = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        height:mediaQuer.size.height*0.06,
        decoration: BoxDecoration(
            color: Colormanager.whiteContainer,
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                '${type}',
                 style:
                  GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15),
               
              ),
            ),
            Text(
              item  ,   
               style:
                    GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize:15), 
           
            ),
          ],
        ),
      ),
    );
  }
}
