import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_doctor/blocs/bloc/auth_bloc.dart';
import 'package:media_doctor/firebase_options.dart';
import 'package:media_doctor/screens/splash/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        child: Container(),
       )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.blueAccent),
          home : const SplashScreen(),
        
        ),
    );
    
    
  }
}