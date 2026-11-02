import '../models/macro_targets.dart';
import '../models/meal.dart';
import '../models/weight_loss_tip.dart';

class SmartTipsEngine {
  const SmartTipsEngine();

  static const _noon = 12;
  static const _evening = 20;
  static const _proteinLagThreshold = 0.15;
  static const _underEatingRatio = 0.6;
  static const _closeToTargetKcal = 200;

  static const _generalTips = [
    WeightLossTip.dailyWalking,
    WeightLossTip.strengthTraining,
    WeightLossTip.sleepWell,
    WeightLossTip.eatFiber,
    WeightLossTip.proteinEveryMeal,
    WeightLossTip.avoidSugaryDrinks,
    WeightLossTip.eatSlowly,
    WeightLossTip.waterBeforeMeals,
    WeightLossTip.moveMoreDaily,
  ];

  /// يختار النصائح حسب استهلاك اليوم مقارنة بالأهداف والوقت الحالي.
  /// النصائح العامة يتغير ترتيبها يومياً حتى لا يرى المستخدم نفس البداية كل مرة.
  SmartTips generate({
    required MacroTargets? targets,
    required DailyTotals totals,
    required DateTime now,
  }) {
    final contextual = _contextualTips(targets, totals, now.hour);
    final dayOfYear = now.difference(DateTime(now.year)).inDays;
    final offset = dayOfYear % _generalTips.length;
    return SmartTips(
      primary: contextual.first,
      contextual: contextual.skip(1).toList(),
      general: [..._generalTips.skip(offset), ..._generalTips.take(offset)],
    );
  }

  // مرتبة حسب الأولوية: الأهم أولاً ويصبح بطاقة النصيحة الذكية
  List<WeightLossTip> _contextualTips(MacroTargets? targets, DailyTotals totals, int hour) {
    if (targets == null) return [WeightLossTip.completeProfile, WeightLossTip.drinkWater];

    if (totals.calories == 0) {
      return [
        hour >= _noon ? WeightLossTip.noMealsYet : WeightLossTip.startWithProteinBreakfast,
        WeightLossTip.drinkWater,
      ];
    }

    final calorieProgress = _progress(totals.calories.toDouble(), targets.targetCalories);
    final proteinProgress = _progress(totals.protein, targets.proteinGrams);
    final carbsProgress = _progress(totals.carbs, targets.carbsGrams);
    final fatsProgress = _progress(totals.fats, targets.fatsGrams);
    final remaining = targets.targetCalories - totals.calories;

    final tips = <WeightLossTip>[
      if (remaining < 0) WeightLossTip.overCalories,
      // البروتين متأخر بوضوح عن نسبة السعرات المستهلكة
      if (proteinProgress < calorieProgress - _proteinLagThreshold) WeightLossTip.lowProtein,
      if (fatsProgress > 1) WeightLossTip.highFats,
      if (carbsProgress > 1) WeightLossTip.highCarbs,
      if (hour >= _evening && calorieProgress < _underEatingRatio) WeightLossTip.underEating,
      if (remaining >= 0 && remaining <= _closeToTargetKcal) WeightLossTip.closeToTarget,
    ];
    if (tips.isEmpty) tips.add(WeightLossTip.onTrack);
    tips.add(WeightLossTip.drinkWater);
    return tips;
  }

  double _progress(double consumed, int target) => target > 0 ? consumed / target : 0;
}
