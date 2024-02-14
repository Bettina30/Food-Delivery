import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '',
        apiKey: '',
        projectId: '',
        messagingSenderId: '',
        iosBundleId: '',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:186341313949:android:e3530abddf786338807374',
        apiKey: 'AIzaSyDs3b5Mrbcv0F_MNwrrJXIahaCF3KoC_cA',
        projectId: 'foodapp-c66d1',
        messagingSenderId: '186341313949',//
        storageBucket: "foodapp-c66d1.appspot.com",
      );
    }
  }
}
