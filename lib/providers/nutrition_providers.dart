import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/nutrition_repository.dart';
import '../domain/models/macro_targets.dart';
import '../domain/models/meal.dart';
import '../domain/models/user_profile.dart';
import '../domain/models/weight_loss_tip.dart';
import '../domain/tips/smart_tips_engine.dart';
import 'auth_providers.dart';
import 'core_providers.dart';

/// مستودع المستخدم الحالي: Firestore عند تفعيل Firebase، وإلا التخزين المحلي. null قبل تسجيل الدخول
final nutritionRepositoryProvider = Provider<NutritionRepository?>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;
  if (ref.watch(firebaseEnabledProvider)) return FirestoreNutritionRepository(uid: user.uid);
  return LocalNutritionRepository(uid: user.uid, prefs: ref.watch(sharedPreferencesProvider));
});

final userProfileProvider = StreamProvider<UserProfile?>((ref) {
  final repository = ref.watch(nutritionRepositoryProvider);
  return repository?.watchProfile() ?? Stream.value(null);
});

final macroTargetsProvider = StreamProvider<MacroTargets?>((ref) {
  final repository = ref.watch(nutritionRepositoryProvider);
  return repository?.watchTargets() ?? Stream.value(null);
});

final todayMealsProvider = StreamProvider<List<Meal>>((ref) {
  final repository = ref.watch(nutritionRepositoryProvider);
  return repository?.watchMealsForDay(DateTime.now()) ?? Stream.value(const []);
});

// يتحدث لحظياً مع كل إضافة أو حذف لوجبة اليوم
final todayTotalsProvider = Provider<DailyTotals>((ref) {
  final meals = ref.watch(todayMealsProvider).value ?? const [];
  return DailyTotals.fromMeals(meals);
});

final smartTipsProvider = Provider<SmartTips>((ref) {
  return const SmartTipsEngine().generate(
    targets: ref.watch(macroTargetsProvider).value,
    totals: ref.watch(todayTotalsProvider),
    now: DateTime.now(),
  );
});
