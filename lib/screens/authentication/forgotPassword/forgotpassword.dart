import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:media_doctor/widgets/textformfield/textformfield.dart';

class ForgotPassword extends StatelessWidget {
    ForgotPassword({super.key});
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Form(
        key: _formkey,
        child: 
          SingleChildScrollView(
              child: SizedBox(
                height: mediaQuery.size.height,
                width: mediaQuery.size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(
                      'Forgot Password',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 32)),
                    ),
                    SizedBox(height: mediaQuery.size.height * 0.03),
                    Text(
                      '''Enter your Email and we will send you a 
                password reset link !''',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colormanager.grayText)),
                    ),
                    SizedBox(height: mediaQuery.size.height * 0.03),
                    CustomTextFormField(
                      // ignore: body_might_complete_normally_nullable
                      value: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your email';
                        }
                      },
                      controller: _emailController,
                      icons: Icon(
                        Icons.email,
                        color: Colormanager.iconscolor,
                      ),
                      Textcolor: Colormanager.grayText,
                      fonrmtype: 'Enter email',
                      formColor: Colormanager.whiteContainer,
                    ),
                    Spacer(),
                    Image.asset('assets/images/forgot.png'),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                             FocusScope.of(context).unfocus(); 

                          }
                        },
                        child: Container(
                          height: mediaQuery.size.height * 0.06,
                          width: mediaQuery.size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colormanager.blueContainer),
                          child: Center(
                              child: Text(
                            'Continue',
                            style: TextStyle(
                                color: Colormanager.whiteText,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.size.height * 0.03,
                    )
                  ],
                ),
              ),
            ),
          
        

      ),
    );
  }
}