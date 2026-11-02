import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/macro_targets.dart';
import '../../domain/models/meal.dart';
import '../../domain/models/user_profile.dart';

abstract class NutritionRepository {
  Stream<UserProfile?> watchProfile();

  Stream<MacroTargets?> watchTargets();

  Future<void> saveProfile(UserProfile profile, MacroTargets targets);

  Stream<List<Meal>> watchMealsForDay(DateTime day);

  /// يعيد الوجبة بمعرّفها؛ وتمرير وجبة لها معرّف يعيدها بنفس المعرّف (للتراجع عن الحذف)
  Future<Meal> addMeal(Meal meal);

  Future<void> deleteMeal(String mealId);
}

/// الهيكل: users/{uid} يحوي profile وtargets، وusers/{uid}/meals لسجل الوجبات.
/// الكتابة لا تنتظر تأكيد الخادم حتى تعمل فوراً بدون إنترنت، وتُزامَن عند عودة الاتصال.
class FirestoreNutritionRepository implements NutritionRepository {
  FirestoreNutritionRepository({required String uid, FirebaseFirestore? firestore})
      : _userDoc = (firestore ?? FirebaseFirestore.instance).collection('users').doc(uid);

  final DocumentReference<Map<String, dynamic>> _userDoc;

  CollectionReference<Map<String, dynamic>> get _meals => _userDoc.collection('meals');

  @override
  Stream<UserProfile?> watchProfile() => _userDoc.snapshots().map((snapshot) {
        final data = snapshot.data()?['profile'];
        return data == null ? null : UserProfile.fromMap(Map<String, dynamic>.from(data as Map));
      });

  @override
  Stream<MacroTargets?> watchTargets() => _userDoc.snapshots().map((snapshot) {
        final data = snapshot.data()?['targets'];
        return data == null ? null : MacroTargets.fromMap(Map<String, dynamic>.from(data as Map));
      });

  @override
  Future<void> saveProfile(UserProfile profile, MacroTargets targets) async {
    _logFailure(_userDoc.set({
      'profile': profile.toMap(),
      'targets': targets.toMap(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true)));
  }

  // الترتيب يتم محلياً لتجنب الحاجة لفهرس مركّب في Firestore
  @override
  Stream<List<Meal>> watchMealsForDay(DateTime day) => _meals
      .where('dayKey', isEqualTo: Meal.dayKeyFor(day))
      .snapshots()
      .map((query) => query.docs.map((doc) => Meal.fromMap(doc.id, doc.data())).toList()
        ..sort((a, b) => a.createdAtMillis.compareTo(b.createdAtMillis)));

  @override
  Future<Meal> addMeal(Meal meal) async {
    final ref = meal.id.isEmpty ? _meals.doc() : _meals.doc(meal.id);
    _logFailure(ref.set(meal.toMap()));
    return meal.copyWith(id: ref.id);
  }

  @override
  Future<void> deleteMeal(String mealId) async {
    _logFailure(_meals.doc(mealId).delete());
  }

  void _logFailure(Future<void> write) {
    write.catchError((Object error) => debugPrint('Firestore write failed: $error'));
  }
}

/// بديل محلي عند غياب Firebase: يحفظ البيانات كـ JSON في SharedPreferences
class LocalNutritionRepository implements NutritionRepository {
  LocalNutritionRepository({required String uid, required this.prefs})
      : _profileKey = 'local_${uid}_profile',
        _targetsKey = 'local_${uid}_targets',
        _mealsKey = 'local_${uid}_meals';

  final SharedPreferences prefs;
  final String _profileKey;
  final String _targetsKey;
  final String _mealsKey;
  final _changes = StreamController<void>.broadcast();

  @override
  Stream<UserProfile?> watchProfile() => _watch(() => _readMap(_profileKey, UserProfile.fromMap));

  @override
  Stream<MacroTargets?> watchTargets() => _watch(() => _readMap(_targetsKey, MacroTargets.fromMap));

  @override
  Future<void> saveProfile(UserProfile profile, MacroTargets targets) async {
    await prefs.setString(_profileKey, jsonEncode(profile.toMap()));
    await prefs.setString(_targetsKey, jsonEncode(targets.toMap()));
    _changes.add(null);
  }

  @override
  Stream<List<Meal>> watchMealsForDay(DateTime day) {
    final dayKey = Meal.dayKeyFor(day);
    return _watch(() => _readMeals().where((meal) => meal.dayKey == dayKey).toList()
      ..sort((a, b) => a.createdAtMillis.compareTo(b.createdAtMillis)));
  }

  @override
  Future<Meal> addMeal(Meal meal) async {
    final saved = meal.id.isEmpty ? meal.copyWith(id: '${DateTime.now().microsecondsSinceEpoch}') : meal;
    final meals = _readMeals()
      ..removeWhere((m) => m.id == saved.id)
      ..add(saved);
    await _writeMeals(meals);
    return saved;
  }

  @override
  Future<void> deleteMeal(String mealId) async {
    await _writeMeals(_readMeals()..removeWhere((m) => m.id == mealId));
  }

  // يرسل القيمة الحالية فوراً ثم يعيد إرسالها مع كل تغيير
  Stream<T> _watch<T>(T Function() read) async* {
    yield read();
    await for (final _ in _changes.stream) {
      yield read();
    }
  }

  T? _readMap<T>(String key, T Function(Map<String, dynamic>) fromMap) {
    final raw = prefs.getString(key);
    return raw == null ? null : fromMap(jsonDecode(raw) as Map<String, dynamic>);
  }

  List<Meal> _readMeals() {
    final raw = prefs.getString(_mealsKey);
    if (raw == null) return [];
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.entries
        .map((entry) => Meal.fromMap(entry.key, entry.value as Map<String, dynamic>))
        .toList();
  }

  Future<void> _writeMeals(List<Meal> meals) async {
    await prefs.setString(_mealsKey, jsonEncode({for (final m in meals) m.id: m.toMap()}));
    _changes.add(null);
  }
}
