// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAjUWPXuOGMDqmQSkuxSQ3zIDZrAbO2skw',
    appId: '1:1006499750145:web:06775c8e357b5f70e63b00',
    messagingSenderId: '1006499750145',
    projectId: 'medica-146ad',
    authDomain: 'medica-146ad.firebaseapp.com',
    storageBucket: 'medica-146ad.appspot.com',
    measurementId: 'G-JD00MHQ852',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUMjSG1X3jeqBOdYEjRhx6PUhSNJG9i1U',
    appId: '1:1006499750145:android:17a20fb55b22b578e63b00',
    messagingSenderId: '1006499750145',
    projectId: 'medica-146ad',
    storageBucket: 'medica-146ad.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBx7iD8NL9Its08RZOoY47sMXEpsgXeMgw',
    appId: '1:1006499750145:ios:93b2f8bb46565f81e63b00',
    messagingSenderId: '1006499750145',
    projectId: 'medica-146ad',
    storageBucket: 'medica-146ad.appspot.com',
    androidClientId: '1006499750145-j5kp1kqp70urlc7toko9gdkj5uqnfv3t.apps.googleusercontent.com',
    iosClientId: '1006499750145-3l3r3uanoarrec63mo2sqircag6rji4l.apps.googleusercontent.com',
    iosBundleId: 'com.example.mediaDoctor',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBx7iD8NL9Its08RZOoY47sMXEpsgXeMgw',
    appId: '1:1006499750145:ios:93b2f8bb46565f81e63b00',
    messagingSenderId: '1006499750145',
    projectId: 'medica-146ad',
    storageBucket: 'medica-146ad.appspot.com',
    androidClientId: '1006499750145-j5kp1kqp70urlc7toko9gdkj5uqnfv3t.apps.googleusercontent.com',
    iosClientId: '1006499750145-3l3r3uanoarrec63mo2sqircag6rji4l.apps.googleusercontent.com',
    iosBundleId: 'com.example.mediaDoctor',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAjUWPXuOGMDqmQSkuxSQ3zIDZrAbO2skw',
    appId: '1:1006499750145:web:97e39b224762d44ce63b00',
    messagingSenderId: '1006499750145',
    projectId: 'medica-146ad',
    authDomain: 'medica-146ad.firebaseapp.com',
    storageBucket: 'medica-146ad.appspot.com',
    measurementId: 'G-9V6YP6BQCC',
  );
}
