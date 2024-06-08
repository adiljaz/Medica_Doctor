import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_doctor/blocs/Forgot/forgot_password_bloc.dart';
import 'package:media_doctor/blocs/Obascure/obscure_bloc.dart';
import 'package:media_doctor/blocs/Weekday/bloc/weekday_bloc.dart';
import 'package:media_doctor/blocs/auth/auth_bloc.dart';
import 'package:media_doctor/blocs/department/bloc/department_bloc.dart';
import 'package:media_doctor/blocs/fromtime/bloc/from_time_bloc.dart';
import 'package:media_doctor/blocs/gender/bloc/gender_bloc.dart';
import 'package:media_doctor/blocs/goggle/bloc/google_auth_bloc.dart';
import 'package:media_doctor/blocs/location/location_bloc.dart';
import 'package:media_doctor/blocs/bottomnav/landing_state_bloc.dart';
import 'package:media_doctor/blocs/dateofbirth/bloc/date_of_birth_bloc.dart';
import 'package:media_doctor/blocs/profile/AddUser/add_user_bloc.dart';
import 'package:media_doctor/blocs/profile/ImageAdding/image_adding_bloc.dart';
import 'package:media_doctor/blocs/profile/ImageUrl/image_url_bloc.dart';
import 'package:media_doctor/blocs/profile/bloc/docurl_bloc.dart';
import 'package:media_doctor/blocs/profile/docimg/docimg_bloc.dart';
import 'package:media_doctor/blocs/totime/bloc/to_bloc.dart';
import 'package:media_doctor/firebase_options.dart';
import 'package:media_doctor/screens/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(CheckLoginStatusEvent()),
          child: const SplashScreen(),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => LandingStateBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => AddUserBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => ImageAddingBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => ImageUrlBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => ObscureBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => DocimgBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => DocurlBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => LocationBlocBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => DateOfBirthBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => GenderBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => DepartmentBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => WeekdayBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => FromTimeBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => ToTimeBloc(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => GoogleAuthBloc(),
          child: Container(),
        )
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blueAccent),
        home: const SplashScreen(),
      ),
    );
  }
}
