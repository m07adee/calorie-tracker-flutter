// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Calorie Tracker';

  @override
  String get onboardingTitle => 'Let\'s start your health journey';

  @override
  String get onboardingSubtitle =>
      'Enter your details and we\'ll calculate your daily needs instantly';

  @override
  String get onboardingSectionGender => 'Gender';

  @override
  String get onboardingSectionBody => 'Body measurements';

  @override
  String get onboardingSectionActivity => 'Daily activity level';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get labelAge => 'Age';

  @override
  String get labelHeight => 'Height';

  @override
  String get labelWeight => 'Current weight';

  @override
  String get labelTargetWeight => 'Target weight';

  @override
  String get unitYears => 'yrs';

  @override
  String get unitCm => 'cm';

  @override
  String get unitKg => 'kg';

  @override
  String get unitKcal => 'kcal';

  @override
  String unitGrams(int value) {
    return '$value g';
  }

  @override
  String unitKcalValue(int value) {
    return '$value kcal';
  }

  @override
  String get activitySedentary => 'Sedentary';

  @override
  String get activitySedentaryDesc => 'Desk job and little movement';

  @override
  String get activityLight => 'Light';

  @override
  String get activityLightDesc => 'Light exercise 1-3 days a week';

  @override
  String get activityModerate => 'Moderate';

  @override
  String get activityModerateDesc => 'Moderate exercise 3-5 days a week';

  @override
  String get activityHigh => 'High';

  @override
  String get activityHighDesc => 'Hard exercise 6-7 days a week';

  @override
  String get activityExtreme => 'Extreme';

  @override
  String get activityExtremeDesc => 'Physical job or training twice a day';

  @override
  String get resultDailyCalories => 'Daily calorie target';

  @override
  String resultBmr(int value) {
    return 'BMR: $value';
  }

  @override
  String resultTdee(int value) {
    return 'TDEE: $value';
  }

  @override
  String get macroProtein => 'Protein';

  @override
  String get macroCarbs => 'Carbs';

  @override
  String get macroFats => 'Fats';

  @override
  String get actionSaveStart => 'Save and start';

  @override
  String get ringRemaining => 'kcal left';

  @override
  String get ringOver => 'kcal over';

  @override
  String get ringTarget => 'Target';

  @override
  String get ringConsumed => 'Eaten';

  @override
  String macroProgressValue(int consumed, int target) {
    return '$consumed / $target g';
  }

  @override
  String macroRemaining(int value) {
    return '$value g left';
  }

  @override
  String macroOver(int value) {
    return '$value g over';
  }

  @override
  String get unitGShort => 'g';

  @override
  String get mealBreakfast => 'Breakfast';

  @override
  String get mealLunch => 'Lunch';

  @override
  String get mealDinner => 'Dinner';

  @override
  String get mealSnack => 'Snack';

  @override
  String get dashboardTitle => 'Your day';

  @override
  String get dashboardAddMeal => '+ Add meal';

  @override
  String get dashboardNoMeals => 'No meals logged yet';

  @override
  String get dashboardMissingProfile =>
      'Complete your health profile first so we can calculate your daily targets';

  @override
  String dashboardMealDetails(int grams, int protein, int carbs, int fats) {
    return '$grams g · Protein $protein · Carbs $carbs · Fats $fats';
  }

  @override
  String get dashboardMealDeleted => 'Meal deleted';

  @override
  String get actionUndo => 'Undo';

  @override
  String get actionDelete => 'Delete';

  @override
  String get addMealTitle => 'Add meal';

  @override
  String get addMealCommonFoods => 'Common foods';

  @override
  String get addMealName => 'Meal name';

  @override
  String get addMealType => 'Meal type';

  @override
  String get addMealQuantity => 'Amount';

  @override
  String get addMealCalories => 'Calories';

  @override
  String get addMealSubmit => 'Add to my day';

  @override
  String addMealPreviewRemaining(int value) {
    return 'You\'ll have $value kcal left today';
  }

  @override
  String addMealPreviewOver(int value) {
    return 'You\'ll exceed your target by $value kcal';
  }

  @override
  String get foodBoiledEggs => 'Boiled eggs';

  @override
  String get foodGrilledChicken => 'Grilled chicken breast';

  @override
  String get foodWhiteRice => 'Cooked white rice';

  @override
  String get foodArabicBread => 'Pita bread';

  @override
  String get foodOats => 'Oats';

  @override
  String get foodYogurt => 'Yogurt';

  @override
  String get foodFoul => 'Foul medames';

  @override
  String get foodHummus => 'Hummus';

  @override
  String get foodSalmon => 'Salmon';

  @override
  String get foodSalad => 'Green salad';

  @override
  String get foodApple => 'Apple';

  @override
  String get foodBanana => 'Banana';

  @override
  String get foodDates => 'Dates';

  @override
  String get foodAlmonds => 'Almonds';

  @override
  String get navHome => 'Home';

  @override
  String get navTips => 'Tips';

  @override
  String get navProfile => 'Profile';

  @override
  String get tipsTitle => 'Health tips';

  @override
  String get tipsSubtitle =>
      'Science-based guidance that adapts to what you eat today';

  @override
  String get tipsSmartLabel => 'Your smart tip right now';

  @override
  String get tipsSectionToday => 'Today\'s alerts';

  @override
  String get tipsSectionGeneral => 'Lose weight faster';

  @override
  String get tipCompleteProfileTitle => 'Complete your health profile';

  @override
  String get tipCompleteProfileBody =>
      'Enter your details in the \"Profile\" tab so we can calculate your targets and personalize your tips.';

  @override
  String get tipProteinBreakfastTitle => 'Start your day with protein';

  @override
  String get tipProteinBreakfastBody =>
      'A protein-rich breakfast like eggs or yogurt reduces hunger and random snacking throughout the day.';

  @override
  String get tipNoMealsTitle => 'No meals logged yet';

  @override
  String get tipNoMealsBody =>
      'Skipping meals increases hunger later and makes overeating more likely. Log a balanced meal now.';

  @override
  String get tipOverCaloriesTitle => 'You passed today\'s target';

  @override
  String get tipOverCaloriesBody =>
      'That\'s okay, one day won\'t ruin your progress. Choose a light dinner of vegetables and protein, and add a 20-minute walk.';

  @override
  String get tipLowProteinTitle => 'Protein is below target';

  @override
  String get tipLowProteinBody =>
      'Add a protein source to your next meal (chicken, fish, eggs, legumes). Protein preserves muscle and keeps you full.';

  @override
  String get tipHighFatsTitle => 'Fats are over target';

  @override
  String get tipHighFatsBody =>
      'Cut back on oils and fried food for the rest of the day, and choose grilling or boiling instead.';

  @override
  String get tipHighCarbsTitle => 'Carbs are over target';

  @override
  String get tipHighCarbsBody =>
      'Make your next meal vegetables with protein, and reduce bread, rice and sweets.';

  @override
  String get tipUnderEatingTitle => 'You have eaten very little today';

  @override
  String get tipUnderEatingBody =>
      'A large deficit slows your metabolism and weakens muscle. Have a balanced meal to get closer to your target.';

  @override
  String get tipCloseToTargetTitle => 'You are close to your target';

  @override
  String get tipCloseToTargetBody =>
      'Great job! If you get hungry, choose a light snack like vegetables or yogurt.';

  @override
  String get tipOnTrackTitle => 'You are on track';

  @override
  String get tipOnTrackBody =>
      'Your meals today are well balanced. Keep up the same pace.';

  @override
  String get tipDrinkWaterTitle => 'Drink water';

  @override
  String get tipDrinkWaterBody =>
      'Aim for at least 8 glasses a day. Thirst is sometimes mistaken for hunger.';

  @override
  String get tipWalkingTitle => 'Walk every day';

  @override
  String get tipWalkingBody =>
      '7,000 to 10,000 steps a day burn extra calories without strain and improve insulin sensitivity.';

  @override
  String get tipStrengthTitle => 'Strength training';

  @override
  String get tipStrengthBody =>
      'Two to three sessions a week preserve muscle mass while losing weight and raise your calorie burn.';

  @override
  String get tipSleepTitle => 'Sleep well';

  @override
  String get tipSleepBody =>
      '7 to 9 hours of sleep regulate hunger and fullness hormones. Poor sleep increases sugar cravings.';

  @override
  String get tipFiberTitle => 'Eat more fiber';

  @override
  String get tipFiberBody =>
      'Vegetables, legumes and oats fill your stomach with few calories and keep you full longer.';

  @override
  String get tipProteinEveryMealTitle => 'Protein in every meal';

  @override
  String get tipProteinEveryMealBody =>
      'Spreading protein across meals increases fullness, and your body uses more energy to digest it.';

  @override
  String get tipSugaryDrinksTitle => 'Avoid sugary drinks';

  @override
  String get tipSugaryDrinksBody =>
      'Juices and soft drinks are liquid calories that don\'t fill you up. Replace them with water or unsweetened tea.';

  @override
  String get tipEatSlowlyTitle => 'Eat slowly';

  @override
  String get tipEatSlowlyBody =>
      'Fullness signals take about 20 minutes to reach your brain. Slow down and chew well.';

  @override
  String get tipWaterBeforeMealsTitle => 'A glass of water before meals';

  @override
  String get tipWaterBeforeMealsBody =>
      'Drinking two glasses of water half an hour before a meal helps reduce how much you eat.';

  @override
  String get tipMoveMoreTitle => 'Move more during the day';

  @override
  String get tipMoveMoreBody =>
      'Take the stairs and stand during calls. Small daily movement burns more calories than you expect.';

  @override
  String get languageMenuLabel => 'Change language';

  @override
  String get authWelcome => 'Welcome';

  @override
  String get authSubtitle =>
      'Sign in to sync your progress across your devices';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authSignIn => 'Sign in';

  @override
  String get authCreateAccount => 'Create account';

  @override
  String get authGoogle => 'Continue with Google';

  @override
  String get authGuest => 'Continue as guest';

  @override
  String get authOr => 'or';

  @override
  String get authLocalMode =>
      'Cloud sync is not set up yet. Your data will be saved on this device.';

  @override
  String get authErrorCredentials => 'Incorrect email or password';

  @override
  String get authErrorEmailInUse => 'This email is already registered';

  @override
  String get authErrorWeakPassword => 'Password must be at least 6 characters';

  @override
  String get authErrorInvalidEmail => 'Enter a valid email';

  @override
  String get authErrorGeneric => 'Something went wrong, please try again';

  @override
  String get actionSignOut => 'Sign out';

  @override
  String get profileSaved => 'Your plan has been updated';

  @override
  String get tipsViewAll => 'All tips';

  @override
  String get dashboardSwipeHint => 'Swipe a meal to delete it';

  @override
  String get loadErrorTitle => 'Couldn\'t load your data';

  @override
  String get loadErrorBody => 'Check your internet connection and try again.';

  @override
  String get actionRetry => 'Retry';
}
