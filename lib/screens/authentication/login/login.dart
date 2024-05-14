import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_doctor/blocs/Obascure/obscure_bloc.dart';
import 'package:media_doctor/blocs/auth/auth_bloc.dart';
import 'package:media_doctor/screens/authentication/forgotPassword/forgotPassword.dart';
import 'package:media_doctor/screens/authentication/signup/sighnup.dart';
import 'package:media_doctor/screens/bottomnav/home.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:media_doctor/widgets/signin/signing.dart';
import 'package:media_doctor/widgets/textformfield/textformfield.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {

          if (state is Authenticated) {
          FocusScope.of(context).unfocus();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => Bottomnav()),
                (route) => false);
          });
        }

        return Scaffold(
          body: Container(
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage(
            //           'assets/images/background.jpg',
            //         ),
            //         fit: BoxFit.cover)),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: SingleChildScrollView(
                  child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: mediaQuery.size.width * 0.1,
                    ),
                    Image.asset('assets/images/sign_in.png'),

                    Text(
                      "Let's you in",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40)),
                    ),

                    SizedBox(
                      height: mediaQuery.size.width * 0.04,
                    ),
                    // emial

                    CustomTextFormField(
                      // ignore: body_might_complete_normally_nullable
                      value: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your email';
                        }
                      },
                      controller: _emailController,
                      Textcolor: Colormanager.grayText,
                      fonrmtype: 'Enter email',
                      formColor: Colormanager.whiteContainer,
                      icons: Icon(
                        Icons.email,
                        size: 27,
                        color: Colormanager.iconscolor,
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    //password

                      BlocBuilder<ObscureBloc, ObscureState>(
                      builder: (context, state) {
                        final st = BlocProvider.of<ObscureBloc>(context).state;

                        return CustomTextFormField(
                          obscuretext: st is Obscurtrue?false:true,

                          // ignore: body_might_complete_normally_nullable
                          value: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your password';
                            }
                          },
                          controller: _passwordController,
                          suficon: InkWell(
                            onTap: () {
                              if (st is Obscurtrue) {
                                BlocProvider.of<ObscureBloc>(context)
                                    .add(ObscureCLick(obscure: false));
                              } else {
                                BlocProvider.of<ObscureBloc>(context)
                                    .add(ObscureCLick(obscure: true));
                              }
                            },
                            child: st is Obscurtrue
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),


                          
                          Textcolor: Colormanager.grayText,
                          fonrmtype: 'Enter password',
                          formColor: Colormanager.whiteContainer,
                          icons: const Icon(
                            FontAwesomeIcons.lock,
                            size: 20,
                            color: Colormanager.iconscolor,
                          ),
                        );
                      },
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colormanager.titleText,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: mediaQuery.size.width * 0.05,
                    ),

                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(email:_emailController.text.trim() , password:_passwordController.text.trim()) ); 
                        }
                      },
                      child: Signin(
                        mediaQuery: mediaQuery,
                        buttontype: 'Sign in',
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.size.width * 0.06,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'or continue with',
                              style: TextStyle(
                                  color: Colormanager.grayText,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: Divider(),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: mediaQuery.size.width * 0.05,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          // signingwith Google
                        },
                        child: Container(
                          height: mediaQuery.size.height * 0.06,
                          width: mediaQuery.size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colormanager.whiteContainer,
                              border: Border.all(
                                  width: 0.5, color: Colormanager.iconscolor)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/googleLogo.png',
                                  ),
                                  fit: BoxFit.cover,
                                  height: 35,
                                ),
                              ),
                              SizedBox(
                                width: mediaQuery.size.width * 0.14,
                              ),
                              Center(
                                  child: Text(
                                'Sign in with Google',
                                style: TextStyle(
                                    color: Colormanager.blackText,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              )),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: mediaQuery.size.width * 0.03,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont't have an account ? ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUp()));
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colormanager.titleText),
                            )),
                      ],
                    )
                  ],
                ),
              )),
            ),
          ),
        );
      },
    );
  }
}
