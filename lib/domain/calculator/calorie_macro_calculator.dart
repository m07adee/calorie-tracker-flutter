import '../models/gender.dart';
import '../models/macro_targets.dart';
import '../models/user_profile.dart';

class CalorieMacroCalculator {
  const CalorieMacroCalculator._();

  static const _weightLossDeficit = 500;
  static const _minCaloriesFemale = 1200;
  static const _minCaloriesMale = 1500;

  static const _proteinRatio = 0.30;
  static const _carbsRatio = 0.40;
  static const _fatsRatio = 0.30;

  static const _kcalPerGramProtein = 4;
  static const _kcalPerGramCarbs = 4;
  static const _kcalPerGramFats = 9;

  // معادلة Mifflin-St Jeor
  static double calculateBmr({
    required Gender gender,
    required double weightKg,
    required double heightCm,
    required int age,
  }) {
    final base = (10 * weightKg) + (6.25 * heightCm) - (5 * age);
    return switch (gender) {
      Gender.male => base + 5,
      Gender.female => base - 161,
    };
  }

  static double calculateTdee(double bmr, double activityMultiplier) => bmr * activityMultiplier;

  // عجز 500 سعرة مع عدم النزول عن الحد الأدنى الآمن حسب الجنس
  static int calculateTargetCalories(double tdee, Gender gender) {
    final minimum = switch (gender) {
      Gender.male => _minCaloriesMale,
      Gender.female => _minCaloriesFemale,
    };
    final target = (tdee - _weightLossDeficit).round();
    return target < minimum ? minimum : target;
  }

  static MacroTargets calculate(UserProfile profile) {
    final bmr = calculateBmr(
      gender: profile.gender,
      weightKg: profile.weightKg,
      heightCm: profile.heightCm,
      age: profile.age,
    );
    final tdee = calculateTdee(bmr, profile.activityLevel.multiplier);
    final targetCalories = calculateTargetCalories(tdee, profile.gender);

    final proteinGrams = (targetCalories * _proteinRatio / _kcalPerGramProtein).round();
    final carbsGrams = (targetCalories * _carbsRatio / _kcalPerGramCarbs).round();
    final fatsGrams = (targetCalories * _fatsRatio / _kcalPerGramFats).round();

    return MacroTargets(
      bmr: bmr.round(),
      tdee: tdee.round(),
      targetCalories: targetCalories,
      proteinGrams: proteinGrams,
      proteinCalories: proteinGrams * _kcalPerGramProtein,
      carbsGrams: carbsGrams,
      carbsCalories: carbsGrams * _kcalPerGramCarbs,
      fatsGrams: fatsGrams,
      fatsCalories: fatsGrams * _kcalPerGramFats,
    );
  }
}
