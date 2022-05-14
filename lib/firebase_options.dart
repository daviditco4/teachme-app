// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAvqpRSNDwLZ82Dl60D0HSIk3dRFf5wkug',
    appId: '1:533900536299:web:fe853e355c79664c2291ae',
    messagingSenderId: '533900536299',
    projectId: 'teachme-itba',
    authDomain: 'teachme-itba.firebaseapp.com',
    storageBucket: 'teachme-itba.appspot.com',
    measurementId: 'G-LK08C3S0MP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADkR3cP0vc913f-qOKhQDkaIXKGJXv3Gg',
    appId: '1:533900536299:android:a4c7ab6e61a8dd842291ae',
    messagingSenderId: '533900536299',
    projectId: 'teachme-itba',
    storageBucket: 'teachme-itba.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBP0vllsRU7U77ep03ksegx9JC1FnfIQeo',
    appId: '1:533900536299:ios:0c26879565d42edf2291ae',
    messagingSenderId: '533900536299',
    projectId: 'teachme-itba',
    storageBucket: 'teachme-itba.appspot.com',
    iosClientId: '533900536299-8jraf57td654i3ftlduatgk20mbh0n4h.apps.googleusercontent.com',
    iosBundleId: 'com.example.teachmeApp',
  );
}