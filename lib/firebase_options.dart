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
    apiKey: 'AIzaSyBzZWmH_jgjUExiIdrFqvKp0Q0V67tv0Po',
    appId: '1:967689631165:web:91438e2c52bad68fe08ed4',
    messagingSenderId: '967689631165',
    projectId: 'schoolsystem-40ddd',
    authDomain: 'schoolsystem-40ddd.firebaseapp.com',
    storageBucket: 'schoolsystem-40ddd.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3wOjRDwdl-KAjaFSJweDYdgnupASNDpk',
    appId: '1:967689631165:android:ad8d06001d40ecd6e08ed4',
    messagingSenderId: '967689631165',
    projectId: 'schoolsystem-40ddd',
    storageBucket: 'schoolsystem-40ddd.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4b60LEJSuogMZoW9n8MHPkHqwmI3Y-V0',
    appId: '1:967689631165:ios:054a9c67bf045efae08ed4',
    messagingSenderId: '967689631165',
    projectId: 'schoolsystem-40ddd',
    storageBucket: 'schoolsystem-40ddd.firebasestorage.app',
    iosBundleId: 'com.example.school',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB4b60LEJSuogMZoW9n8MHPkHqwmI3Y-V0',
    appId: '1:967689631165:ios:054a9c67bf045efae08ed4',
    messagingSenderId: '967689631165',
    projectId: 'schoolsystem-40ddd',
    storageBucket: 'schoolsystem-40ddd.firebasestorage.app',
    iosBundleId: 'com.example.school',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBzZWmH_jgjUExiIdrFqvKp0Q0V67tv0Po',
    appId: '1:967689631165:web:3f910d7d5d50ceece08ed4',
    messagingSenderId: '967689631165',
    projectId: 'schoolsystem-40ddd',
    authDomain: 'schoolsystem-40ddd.firebaseapp.com',
    storageBucket: 'schoolsystem-40ddd.firebasestorage.app',
  );
}
