import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:suprapp/app/state/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase for all platforms
  try {
    if (kIsWeb) {
      // For web, initialize with options
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyDMSfgpApQOGCcC4shiHGndaCocFmuF6Aw",
          authDomain: "aslibaray-f20ed.firebaseapp.com",
          projectId: "aslibaray-f20ed",
          storageBucket: "aslibaray-f20ed.firebasestorage.app",
          messagingSenderId: "449982728538",
          appId: "1:449982728538:android:ee3e786a6f9ca8c4388b63",
        ),
      );
    } else {
      // For mobile platforms, initialize normally
      await Firebase.initializeApp();
    }
  } catch (e) {
    // If Firebase initialization fails, continue without it
    print('Firebase initialization failed: $e');
  }
  
  runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}