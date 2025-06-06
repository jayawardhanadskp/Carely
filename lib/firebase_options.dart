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
    apiKey: 'AIzaSyCYjPwhSXVJ5gB43gVuucMwbarXpK-3sUE',
    appId: '1:520239783476:web:758c7bc7d909d88fa17461',
    messagingSenderId: '520239783476',
    projectId: 'carely-d1d6b',
    authDomain: 'carely-d1d6b.firebaseapp.com',
    storageBucket: 'carely-d1d6b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD89CYXy0ots3ekee0gSCVhaLcKa82v1DI',
    appId: '1:520239783476:android:02bb91bca5b480a7a17461',
    messagingSenderId: '520239783476',
    projectId: 'carely-d1d6b',
    storageBucket: 'carely-d1d6b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkyBopCXzm0vngYIpdMHLPDuiZIVdMPls',
    appId: '1:520239783476:ios:5ad2f86b0944a9e8a17461',
    messagingSenderId: '520239783476',
    projectId: 'carely-d1d6b',
    storageBucket: 'carely-d1d6b.firebasestorage.app',
    iosBundleId: 'com.carely.carely',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDkyBopCXzm0vngYIpdMHLPDuiZIVdMPls',
    appId: '1:520239783476:ios:5ad2f86b0944a9e8a17461',
    messagingSenderId: '520239783476',
    projectId: 'carely-d1d6b',
    storageBucket: 'carely-d1d6b.firebasestorage.app',
    iosBundleId: 'com.carely.carely',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCYjPwhSXVJ5gB43gVuucMwbarXpK-3sUE',
    appId: '1:520239783476:web:b105e867a9e96180a17461',
    messagingSenderId: '520239783476',
    projectId: 'carely-d1d6b',
    authDomain: 'carely-d1d6b.firebaseapp.com',
    storageBucket: 'carely-d1d6b.firebasestorage.app',
  );
}
