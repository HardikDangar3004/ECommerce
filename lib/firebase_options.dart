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
///   options: currentPlatform,
/// );
/// ```

FirebaseOptions get currentPlatform {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return android;
    case TargetPlatform.iOS:
      return ios;
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
    case TargetPlatform.linux:
      throw UnsupportedError(
        'Firebase options are not supported for this platform.',
      );
    default:
      throw UnsupportedError(
        'Firebase options are not supported for this platform.',
      );
  }
}

const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyDeyB6xOj2l9U2TFLr1UFMqxgk0rLD7XW0',
  appId: '1:70841341565:android:7083e5f86cab6daa004314',
  messagingSenderId: '70841341565',
  projectId: 'ecommerce-93ce1',
  storageBucket: 'ecommerce-93ce1.firebasestorage.app',
);

const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'AIzaSyDeyB6xOj2l9U2TFLr1UFMqxgk0rLD7XW0',
  appId: '1:70841341565:ios:7083e5f86cab6daa004314',
  messagingSenderId: '70841341565',
  projectId: 'ecommerce-93ce1',
  storageBucket: 'ecommerce-93ce1.firebasestorage.app',
  iosBundleId: 'com.example.ecommerceDemo',
);
