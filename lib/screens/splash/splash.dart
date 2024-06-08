import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:media_doctor/blocs/auth/auth_bloc.dart';
import 'package:media_doctor/screens/authentication/login/login.dart';
import 'package:media_doctor/screens/bottomnav/bottomnav.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Bottomnav()));
        }else if( state is UnAuthenticated){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage())); 
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(PageTransition(
                child: LoginPage(), type: PageTransitionType.fade));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.fill,
                    height: mediaQuery.size.height * 0.12,
                    width: mediaQuery.size.height * 0.12,
                  ),
                  Text(
                    'Medica',
                    style: GoogleFonts.signika(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35)),
                  )
                ],
              ),
              Spacer(),
              Lottie.asset('assets/lottie/loading.json',
                  fit: BoxFit.cover,
                  width: mediaQuery.size.height * 0.15,
                  height: mediaQuery.size.height * 0.15)
            ],
          ),
        ),
      ),
    );
  }
}
