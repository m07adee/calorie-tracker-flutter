import '../../domain/foods/common_foods.dart';
import '../../domain/models/activity_level.dart';
import '../../domain/models/gender.dart';
import '../../domain/models/meal_type.dart';
import '../../domain/models/weight_loss_tip.dart';
import '../../l10n/app_localizations.dart';

// ربط نماذج الطبقة الأساسية بنصوصها المترجمة في ملفات ARB

extension GenderText on Gender {
  String label(AppLocalizations l10n) => switch (this) {
        Gender.male => l10n.genderMale,
        Gender.female => l10n.genderFemale,
      };
}

extension ActivityLevelText on ActivityLevel {
  String label(AppLocalizations l10n) => switch (this) {
        ActivityLevel.sedentary => l10n.activitySedentary,
        ActivityLevel.light => l10n.activityLight,
        ActivityLevel.moderate => l10n.activityModerate,
        ActivityLevel.high => l10n.activityHigh,
        ActivityLevel.extreme => l10n.activityExtreme,
      };

  String description(AppLocalizations l10n) => switch (this) {
        ActivityLevel.sedentary => l10n.activitySedentaryDesc,
        ActivityLevel.light => l10n.activityLightDesc,
        ActivityLevel.moderate => l10n.activityModerateDesc,
        ActivityLevel.high => l10n.activityHighDesc,
        ActivityLevel.extreme => l10n.activityExtremeDesc,
      };
}

extension MealTypeText on MealType {
  String label(AppLocalizations l10n) => switch (this) {
        MealType.breakfast => l10n.mealBreakfast,
        MealType.lunch => l10n.mealLunch,
        MealType.dinner => l10n.mealDinner,
        MealType.snack => l10n.mealSnack,
      };
}

extension CommonFoodText on CommonFood {
  String name(AppLocalizations l10n) => switch (id) {
        CommonFoodId.boiledEggs => l10n.foodBoiledEggs,
        CommonFoodId.grilledChicken => l10n.foodGrilledChicken,
        CommonFoodId.whiteRice => l10n.foodWhiteRice,
        CommonFoodId.arabicBread => l10n.foodArabicBread,
        CommonFoodId.oats => l10n.foodOats,
        CommonFoodId.yogurt => l10n.foodYogurt,
        CommonFoodId.foul => l10n.foodFoul,
        CommonFoodId.hummus => l10n.foodHummus,
        CommonFoodId.salmon => l10n.foodSalmon,
        CommonFoodId.salad => l10n.foodSalad,
        CommonFoodId.apple => l10n.foodApple,
        CommonFoodId.banana => l10n.foodBanana,
        CommonFoodId.dates => l10n.foodDates,
        CommonFoodId.almonds => l10n.foodAlmonds,
      };
}

extension WeightLossTipText on WeightLossTip {
  String title(AppLocalizations l10n) => switch (this) {
        WeightLossTip.completeProfile => l10n.tipCompleteProfileTitle,
        WeightLossTip.startWithProteinBreakfast => l10n.tipProteinBreakfastTitle,
        WeightLossTip.noMealsYet => l10n.tipNoMealsTitle,
        WeightLossTip.overCalories => l10n.tipOverCaloriesTitle,
        WeightLossTip.lowProtein => l10n.tipLowProteinTitle,
        WeightLossTip.highFats => l10n.tipHighFatsTitle,
        WeightLossTip.highCarbs => l10n.tipHighCarbsTitle,
        WeightLossTip.underEating => l10n.tipUnderEatingTitle,
        WeightLossTip.closeToTarget => l10n.tipCloseToTargetTitle,
        WeightLossTip.onTrack => l10n.tipOnTrackTitle,
        WeightLossTip.drinkWater => l10n.tipDrinkWaterTitle,
        WeightLossTip.dailyWalking => l10n.tipWalkingTitle,
        WeightLossTip.strengthTraining => l10n.tipStrengthTitle,
        WeightLossTip.sleepWell => l10n.tipSleepTitle,
        WeightLossTip.eatFiber => l10n.tipFiberTitle,
        WeightLossTip.proteinEveryMeal => l10n.tipProteinEveryMealTitle,
        WeightLossTip.avoidSugaryDrinks => l10n.tipSugaryDrinksTitle,
        WeightLossTip.eatSlowly => l10n.tipEatSlowlyTitle,
        WeightLossTip.waterBeforeMeals => l10n.tipWaterBeforeMealsTitle,
        WeightLossTip.moveMoreDaily => l10n.tipMoveMoreTitle,
      };

  String body(AppLocalizations l10n) => switch (this) {
        WeightLossTip.completeProfile => l10n.tipCompleteProfileBody,
        WeightLossTip.startWithProteinBreakfast => l10n.tipProteinBreakfastBody,
        WeightLossTip.noMealsYet => l10n.tipNoMealsBody,
        WeightLossTip.overCalories => l10n.tipOverCaloriesBody,
        WeightLossTip.lowProtein => l10n.tipLowProteinBody,
        WeightLossTip.highFats => l10n.tipHighFatsBody,
        WeightLossTip.highCarbs => l10n.tipHighCarbsBody,
        WeightLossTip.underEating => l10n.tipUnderEatingBody,
        WeightLossTip.closeToTarget => l10n.tipCloseToTargetBody,
        WeightLossTip.onTrack => l10n.tipOnTrackBody,
        WeightLossTip.drinkWater => l10n.tipDrinkWaterBody,
        WeightLossTip.dailyWalking => l10n.tipWalkingBody,
        WeightLossTip.strengthTraining => l10n.tipStrengthBody,
        WeightLossTip.sleepWell => l10n.tipSleepBody,
        WeightLossTip.eatFiber => l10n.tipFiberBody,
        WeightLossTip.proteinEveryMeal => l10n.tipProteinEveryMealBody,
        WeightLossTip.avoidSugaryDrinks => l10n.tipSugaryDrinksBody,
        WeightLossTip.eatSlowly => l10n.tipEatSlowlyBody,
        WeightLossTip.waterBeforeMeals => l10n.tipWaterBeforeMealsBody,
        WeightLossTip.moveMoreDaily => l10n.tipMoveMoreBody,
      };
}
