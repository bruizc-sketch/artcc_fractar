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
    apiKey: 'AIzaSyAGmBw8HMWEVglqEkL0QMHRen4smu_LjAQ',
    appId: '1:692330269858:web:a82f1cc229b6d70b4adbfb',
    messagingSenderId: '692330269858',
    projectId: 'aplica-movil-ffa0b',
    authDomain: 'aplica-movil-ffa0b.firebaseapp.com',
    storageBucket: 'aplica-movil-ffa0b.firebasestorage.app',
    measurementId: 'G-CZKGLBWLZ2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBehWQ_Jl9pIHXHVb6yMNhbiqEPQcK-7vs',
    appId: '1:692330269858:android:30ed53a93c236b6b4adbfb',
    messagingSenderId: '692330269858',
    projectId: 'aplica-movil-ffa0b',
    storageBucket: 'aplica-movil-ffa0b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB56HAuVLgl_lIUeayP0yFedzL9VY7zKw8',
    appId: '1:692330269858:ios:ae7d9543c178a8a64adbfb',
    messagingSenderId: '692330269858',
    projectId: 'aplica-movil-ffa0b',
    storageBucket: 'aplica-movil-ffa0b.firebasestorage.app',
    iosBundleId: 'com.example.artccFractar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB56HAuVLgl_lIUeayP0yFedzL9VY7zKw8',
    appId: '1:692330269858:ios:ae7d9543c178a8a64adbfb',
    messagingSenderId: '692330269858',
    projectId: 'aplica-movil-ffa0b',
    storageBucket: 'aplica-movil-ffa0b.firebasestorage.app',
    iosBundleId: 'com.example.artccFractar',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAGmBw8HMWEVglqEkL0QMHRen4smu_LjAQ',
    appId: '1:692330269858:web:fca3bd3f31d037ae4adbfb',
    messagingSenderId: '692330269858',
    projectId: 'aplica-movil-ffa0b',
    authDomain: 'aplica-movil-ffa0b.firebaseapp.com',
    storageBucket: 'aplica-movil-ffa0b.firebasestorage.app',
    measurementId: 'G-C6GHYB7564',
  );

}