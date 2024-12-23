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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgIj6PGNYqNQPKJQmSV_SH0U0r0FlEjJw',
    appId: '1:338108213037:android:dac08dbe306c79bf4115a4',
    messagingSenderId: '338108213037',
    projectId: 'habits-asultan',
    storageBucket: 'habits-asultan.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBSy1pVxGLNV_-6fyfI_B5V_8bmi54CVys',
    appId: '1:338108213037:ios:9ce9ba5c41d38f014115a4',
    messagingSenderId: '338108213037',
    projectId: 'habits-asultan',
    storageBucket: 'habits-asultan.firebasestorage.app',
    iosBundleId: 'com.example.habits',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBiZNdBDmMi0b9lsrPn92jWoE3CpJHbY2w',
    appId: '1:338108213037:web:b47e3f3f954c13504115a4',
    messagingSenderId: '338108213037',
    projectId: 'habits-asultan',
    authDomain: 'habits-asultan.firebaseapp.com',
    storageBucket: 'habits-asultan.firebasestorage.app',
    measurementId: 'G-Y7M612QTY1',
  );
}
