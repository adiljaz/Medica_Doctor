import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_doctor/blocs/Obascure/obscure_bloc.dart';
import 'package:media_doctor/blocs/auth/auth_bloc.dart';
import 'package:media_doctor/models/user_model.dart';
import 'package:media_doctor/screens/adprofiledata/addrofile.dart';
import 'package:media_doctor/screens/authentication/login/login.dart';
import 'package:media_doctor/screens/bottomnav/bottomnav.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';
import 'package:media_doctor/widgets/textformfield/textformfield.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  SignUp({super.key});

  TextEditingController _usernameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AddProfile()));
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
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                      height: 320,
                    ),
                    Text(
                      "Create New Account",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ),

                    // emial

                    SizedBox(
                      height: mediaQuery.size.width * 0.04,
                    ),

                    CustomTextFormField(
                      // ignore: body_might_complete_normally_nullable
                      value: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your username';
                        }
                      },
                      controller: _usernameController,
                      Textcolor: Colormanager.grayText,
                      fonrmtype: 'Enter username',
                      formColor: Colormanager.whiteContainer,
                      icons: Icon(
                        Icons.account_circle,
                        size: 27,
                        color: Colormanager.iconscolor,
                      ),
                    ),

                    SizedBox(
                      height: mediaQuery.size.width * 0.04,
                    ),

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
                      height: mediaQuery.size.width * 0.04,
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

                    SizedBox(
                      height: mediaQuery.size.width * 0.04,
                    ),

                    // reginster button

                    GestureDetector(
                      onTap: () {
                        UserModel user = UserModel(
                          userName: _usernameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        BlocProvider.of<AuthBloc>(context)
                            .add(SignupEvent(user: user));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          height: mediaQuery.size.height * 0.06,
                          width: mediaQuery.size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colormanager.blueContainer),
                          child: Center(
                              child: Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colormanager.whiteText,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )),
                        ),
                      ),
                    ),

                    // GestureDetector(
                    //     onTap: () {

                    //         print('navigationg-----------------');
                    //       UserModel user = UserModel(
                    //         email: _emailController.text,
                    //         password: _passwordController.text,
                    //         userName: _usernameController.text,
                    //       );

                    //       authbloc.add(SignupEvent(user: user));
                    //     },
                    //     child: Signin(
                    //       mediaQuery: mediaQuery,
                    //       buttontype: 'Sign up',
                    //     )),

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
                        onTap: () {},
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
                                builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colormanager.titleText),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
