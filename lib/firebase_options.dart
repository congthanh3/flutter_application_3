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
    apiKey: 'AIzaSyCuHXzoi8vVbD047--qCXBBQ6ILBCUp27w',
    appId: '1:722117662550:web:d8d11f9b6c88b28191e8f7',
    messagingSenderId: '722117662550',
    projectId: 'appchatjun2022',
    authDomain: 'appchatjun2022.firebaseapp.com',
    storageBucket: 'appchatjun2022.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6D_kptZGKRGvngfUPjM3pQEeWw-1QvFQ',
    appId: '1:722117662550:android:2c1f899faf22d3e491e8f7',
    messagingSenderId: '722117662550',
    projectId: 'appchatjun2022',
    storageBucket: 'appchatjun2022.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAhcn3ZH46hImPyhd7d9VaVci8KeoQpcuA',
    appId: '1:722117662550:ios:b5bd81b8b270522391e8f7',
    messagingSenderId: '722117662550',
    projectId: 'appchatjun2022',
    storageBucket: 'appchatjun2022.appspot.com',
    iosClientId: '722117662550-7j8stt9gi40l7iedmlocl22i2iguglop.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication3',
  );
}
