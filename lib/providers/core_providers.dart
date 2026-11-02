import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// تُمرَّر قيمتها الفعلية من main.dart عبر overrides بعد التهيئة
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider must be overridden in main'),
);

/// true عند نجاح تهيئة Firebase، وfalse للعمل بوضع التخزين المحلي
final firebaseEnabledProvider = Provider<bool>((ref) => false);
