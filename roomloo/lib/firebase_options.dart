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
    apiKey: 'AIzaSyBojPCTjI1eEdka2SvrxOduZ_CksgoyFfw',
    appId: '1:931744400405:web:7c95180fc5ff9c98893a1c',
    messagingSenderId: '931744400405',
    projectId: 'roomloo-85213',
    authDomain: 'roomloo-85213.firebaseapp.com',
    storageBucket: 'roomloo-85213.firebasestorage.app',
    measurementId: 'G-WV79CZE0KJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_Y74EZcVx1gF8JqFwctuIxVxnWUDbUeI',
    appId: '1:931744400405:android:68b3ddd69846f6cd893a1c',
    messagingSenderId: '931744400405',
    projectId: 'roomloo-85213',
    storageBucket: 'roomloo-85213.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBubMf0SLWrDq29LbnafC6h1y8bDVFZVJw',
    appId: '1:931744400405:ios:1c4623d8c1b00d76893a1c',
    messagingSenderId: '931744400405',
    projectId: 'roomloo-85213',
    storageBucket: 'roomloo-85213.firebasestorage.app',
    iosBundleId: 'com.example.roomloo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBubMf0SLWrDq29LbnafC6h1y8bDVFZVJw',
    appId: '1:931744400405:ios:1c4623d8c1b00d76893a1c',
    messagingSenderId: '931744400405',
    projectId: 'roomloo-85213',
    storageBucket: 'roomloo-85213.firebasestorage.app',
    iosBundleId: 'com.example.roomloo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBojPCTjI1eEdka2SvrxOduZ_CksgoyFfw',
    appId: '1:931744400405:web:542bd5f6e9783e01893a1c',
    messagingSenderId: '931744400405',
    projectId: 'roomloo-85213',
    authDomain: 'roomloo-85213.firebaseapp.com',
    storageBucket: 'roomloo-85213.firebasestorage.app',
    measurementId: 'G-JRXBXNZSNM',
  );

}