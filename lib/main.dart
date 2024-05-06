import 'package:flutter/material.dart';
import 'package:media_doctor/screens/splash/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blueAccent),
        home : const SplashScreen(),
      
      );
    
  }
}