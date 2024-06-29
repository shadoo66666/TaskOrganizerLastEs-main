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
    apiKey: 'AIzaSyC4GrjP__PE8OOXpmGcycItDCUN35dN4hM',
    appId: '1:825413902810:web:05799f6e589d227aa1a0e3',
    messagingSenderId: '825413902810',
    projectId: 'task-orga',
    authDomain: 'task-orga.firebaseapp.com',
    storageBucket: 'task-orga.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARSfSodVWKlYie3wmend-k0N42d35SdgI',
    appId: '1:825413902810:android:d0459693e253ee0da1a0e3',
    messagingSenderId: '825413902810',
    projectId: 'task-orga',
    storageBucket: 'task-orga.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYTMDfmrRXSwWrLwebabH1kdtAdmiqluw',
    appId: '1:825413902810:ios:5f5b2226e8e3a684a1a0e3',
    messagingSenderId: '825413902810',
    projectId: 'task-orga',
    storageBucket: 'task-orga.appspot.com',
    iosBundleId: 'com.example.taskApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAYTMDfmrRXSwWrLwebabH1kdtAdmiqluw',
    appId: '1:825413902810:ios:5f5b2226e8e3a684a1a0e3',
    messagingSenderId: '825413902810',
    projectId: 'task-orga',
    storageBucket: 'task-orga.appspot.com',
    iosBundleId: 'com.example.taskApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC4GrjP__PE8OOXpmGcycItDCUN35dN4hM',
    appId: '1:825413902810:web:518e5882d7469997a1a0e3',
    messagingSenderId: '825413902810',
    projectId: 'task-orga',
    authDomain: 'task-orga.firebaseapp.com',
    storageBucket: 'task-orga.appspot.com',
  );

}