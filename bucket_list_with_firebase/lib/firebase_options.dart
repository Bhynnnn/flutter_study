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
    apiKey: 'AIzaSyA8ps-AecFdPpDaH47FxOBqqMhA8XosNOY',
    appId: '1:1024009601785:web:2db6e06eff7ceb84bb9828',
    messagingSenderId: '1024009601785',
    projectId: 'bucketlistwithfirebase-9e107',
    authDomain: 'bucketlistwithfirebase-9e107.firebaseapp.com',
    storageBucket: 'bucketlistwithfirebase-9e107.appspot.com',
    measurementId: 'G-1ET03CZ37Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnEd10w38q8vxprd88GhZ_tI-5SgYV5qs',
    appId: '1:1024009601785:android:a095331d4d8033c7bb9828',
    messagingSenderId: '1024009601785',
    projectId: 'bucketlistwithfirebase-9e107',
    storageBucket: 'bucketlistwithfirebase-9e107.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6ZllMTielraisF7eG38a1Ll2Y3BYSfaw',
    appId: '1:1024009601785:ios:737cb3f45a336e8bbb9828',
    messagingSenderId: '1024009601785',
    projectId: 'bucketlistwithfirebase-9e107',
    storageBucket: 'bucketlistwithfirebase-9e107.appspot.com',
    iosBundleId: 'com.example.bucketListWithFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD6ZllMTielraisF7eG38a1Ll2Y3BYSfaw',
    appId: '1:1024009601785:ios:737cb3f45a336e8bbb9828',
    messagingSenderId: '1024009601785',
    projectId: 'bucketlistwithfirebase-9e107',
    storageBucket: 'bucketlistwithfirebase-9e107.appspot.com',
    iosBundleId: 'com.example.bucketListWithFirebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA8ps-AecFdPpDaH47FxOBqqMhA8XosNOY',
    appId: '1:1024009601785:web:9a567a06a1027a41bb9828',
    messagingSenderId: '1024009601785',
    projectId: 'bucketlistwithfirebase-9e107',
    authDomain: 'bucketlistwithfirebase-9e107.firebaseapp.com',
    storageBucket: 'bucketlistwithfirebase-9e107.appspot.com',
    measurementId: 'G-BNW5Q4GCPM',
  );
}