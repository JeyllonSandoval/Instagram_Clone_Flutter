// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
  apiKey: "AIzaSyAQ4s0PC8rMOUVt6iwtNwf580shN54yiIk",
  authDomain: "instagramclone-74a5e.firebaseapp.com",
  projectId: "instagramclone-74a5e",
  storageBucket: "instagramclone-74a5e.firebasestorage.app",
  messagingSenderId: "183646428728",
  appId: "1:183646428728:web:c7dbce77b1ebc68c5710cd",
  measurementId: "G-WF3GT1GHJZ"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgvoKtVvRoneHO7gMYp3bHLRXqOdZlSSQ',
    appId: '1:183646428728:android:ecdcc9148c7d84ee5710cd',
    messagingSenderId: '183646428728',
    projectId: 'instagramclone-74a5e',
    storageBucket: 'instagramclone-74a5e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHcwwBV11fUm6z-ZkQX9iudQspylXK_-M',
    appId: '1:183646428728:ios:613a8022104f6a195710cd',
    messagingSenderId: '183646428728',
    projectId: 'instagramclone-74a5e',
    storageBucket: 'instagramclone-74a5e.firebasestorage.app',
    iosBundleId: 'com.example.instagramCloneFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAHcwwBV11fUm6z-ZkQX9iudQspylXK_-M',
    appId: '1:183646428728:ios:613a8022104f6a195710cd',
    messagingSenderId: '183646428728',
    projectId: 'instagramclone-74a5e',
    storageBucket: 'instagramclone-74a5e.firebasestorage.app',
    iosBundleId: 'com.example.instagramCloneFlutter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAQ4s0PC8rMOUVt6iwtNwf580shN54yiIk',
    appId: '1:183646428728:web:ed582744638cc4fb5710cd',
    messagingSenderId: '183646428728',
    projectId: 'instagramclone-74a5e',
    authDomain: 'instagramclone-74a5e.firebaseapp.com',
    storageBucket: 'instagramclone-74a5e.firebasestorage.app',
    measurementId: 'G-VRT77Z5CN4',
  );
}
