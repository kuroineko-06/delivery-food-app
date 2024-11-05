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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCRxsAULK_6A9zytGBF_hHbj7iAOSaHv5U',
    appId: '1:79494619561:web:fb3872471e8989cc8aa4b8',
    messagingSenderId: '79494619561',
    projectId: 'foodly-flutter-730ee',
    authDomain: 'foodly-flutter-730ee.firebaseapp.com',
    storageBucket: 'foodly-flutter-730ee.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsmgbVLEnKVVagF94KJAjlAJxF3piGUxM',
    appId: '1:79494619561:android:be6d6afd6e0b9f8d8aa4b8',
    messagingSenderId: '79494619561',
    projectId: 'foodly-flutter-730ee',
    storageBucket: 'foodly-flutter-730ee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwiBpM-GH_9bBkQEBKH-MgqzAOsz96Dks',
    appId: '1:79494619561:ios:5874566abaf326a68aa4b8',
    messagingSenderId: '79494619561',
    projectId: 'foodly-flutter-730ee',
    storageBucket: 'foodly-flutter-730ee.appspot.com',
    iosClientId: '79494619561-dcj8dnumlh7ltjmqibs866ihfj5i3eav.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodly',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwiBpM-GH_9bBkQEBKH-MgqzAOsz96Dks',
    appId: '1:79494619561:ios:5874566abaf326a68aa4b8',
    messagingSenderId: '79494619561',
    projectId: 'foodly-flutter-730ee',
    storageBucket: 'foodly-flutter-730ee.appspot.com',
    iosClientId: '79494619561-dcj8dnumlh7ltjmqibs866ihfj5i3eav.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodly',
  );
}
