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
    apiKey: '**',
    appId: '***',
    messagingSenderId: '**',
    projectId: '**',
    authDomain: '**',
    storageBucket: '***',
    measurementId: '**',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '**',
    appId: '1:116259425904:android:**',
    messagingSenderId: '**',
    projectId: 'push-**-34e5c',
    storageBucket: 'push-**-**.**.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '**',
    appId: '1:**:**:**',
    messagingSenderId: '**',
    projectId: '**-**-**',
    storageBucket: '**-**-**.**.com',
    iosBundleId: 'com.example.fcmVoiceCall',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '**',
    appId: '1:**:ios:**',
    messagingSenderId: '**',
    projectId: '**-**-**',
    storageBucket: '**-**-**.**.**',
    iosBundleId: 'com.example.fcmVoiceCall',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: '**',
    appId: '1:**:**:**',
    messagingSenderId: '**',
    projectId: '**-**-**',
    authDomain: '**-**-**.**.**',
    storageBucket: '**-**-**.**.**',
    measurementId: '**-**',
  );
}