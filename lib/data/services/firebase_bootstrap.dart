import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseBootstrap {
  const FirebaseBootstrap._();

  /// يحاول تهيئة Firebase ويعيد true عند النجاح.
  /// عند غياب google-services.json يفشل بأمان فيعمل التطبيق بوضع التخزين المحلي.
  static Future<bool> initialize() async {
    try {
      await Firebase.initializeApp();
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
      return true;
    } catch (error) {
      debugPrint('Firebase unavailable, using local storage mode: $error');
      return false;
    }
  }
}
