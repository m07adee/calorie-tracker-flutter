import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Calorie Tracker'**
  String get appName;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s start your health journey'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your details and we\'ll calculate your daily needs instantly'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingSectionGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get onboardingSectionGender;

  /// No description provided for @onboardingSectionBody.
  ///
  /// In en, this message translates to:
  /// **'Body measurements'**
  String get onboardingSectionBody;

  /// No description provided for @onboardingSectionActivity.
  ///
  /// In en, this message translates to:
  /// **'Daily activity level'**
  String get onboardingSectionActivity;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @labelAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get labelAge;

  /// No description provided for @labelHeight.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get labelHeight;

  /// No description provided for @labelWeight.
  ///
  /// In en, this message translates to:
  /// **'Current weight'**
  String get labelWeight;

  /// No description provided for @labelTargetWeight.
  ///
  /// In en, this message translates to:
  /// **'Target weight'**
  String get labelTargetWeight;

  /// No description provided for @unitYears.
  ///
  /// In en, this message translates to:
  /// **'yrs'**
  String get unitYears;

  /// No description provided for @unitCm.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get unitCm;

  /// No description provided for @unitKg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKg;

  /// No description provided for @unitKcal.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get unitKcal;

  /// No description provided for @unitGrams.
  ///
  /// In en, this message translates to:
  /// **'{value} g'**
  String unitGrams(int value);

  /// No description provided for @unitKcalValue.
  ///
  /// In en, this message translates to:
  /// **'{value} kcal'**
  String unitKcalValue(int value);

  /// No description provided for @activitySedentary.
  ///
  /// In en, this message translates to:
  /// **'Sedentary'**
  String get activitySedentary;

  /// No description provided for @activitySedentaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Desk job and little movement'**
  String get activitySedentaryDesc;

  /// No description provided for @activityLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get activityLight;

  /// No description provided for @activityLightDesc.
  ///
  /// In en, this message translates to:
  /// **'Light exercise 1-3 days a week'**
  String get activityLightDesc;

  /// No description provided for @activityModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get activityModerate;

  /// No description provided for @activityModerateDesc.
  ///
  /// In en, this message translates to:
  /// **'Moderate exercise 3-5 days a week'**
  String get activityModerateDesc;

  /// No description provided for @activityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get activityHigh;

  /// No description provided for @activityHighDesc.
  ///
  /// In en, this message translates to:
  /// **'Hard exercise 6-7 days a week'**
  String get activityHighDesc;

  /// No description provided for @activityExtreme.
  ///
  /// In en, this message translates to:
  /// **'Extreme'**
  String get activityExtreme;

  /// No description provided for @activityExtremeDesc.
  ///
  /// In en, this message translates to:
  /// **'Physical job or training twice a day'**
  String get activityExtremeDesc;

  /// No description provided for @resultDailyCalories.
  ///
  /// In en, this message translates to:
  /// **'Daily calorie target'**
  String get resultDailyCalories;

  /// No description provided for @resultBmr.
  ///
  /// In en, this message translates to:
  /// **'BMR: {value}'**
  String resultBmr(int value);

  /// No description provided for @resultTdee.
  ///
  /// In en, this message translates to:
  /// **'TDEE: {value}'**
  String resultTdee(int value);

  /// No description provided for @macroProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get macroProtein;

  /// No description provided for @macroCarbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get macroCarbs;

  /// No description provided for @macroFats.
  ///
  /// In en, this message translates to:
  /// **'Fats'**
  String get macroFats;

  /// No description provided for @actionSaveStart.
  ///
  /// In en, this message translates to:
  /// **'Save and start'**
  String get actionSaveStart;

  /// No description provided for @ringRemaining.
  ///
  /// In en, this message translates to:
  /// **'kcal left'**
  String get ringRemaining;

  /// No description provided for @ringOver.
  ///
  /// In en, this message translates to:
  /// **'kcal over'**
  String get ringOver;

  /// No description provided for @ringTarget.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get ringTarget;

  /// No description provided for @ringConsumed.
  ///
  /// In en, this message translates to:
  /// **'Eaten'**
  String get ringConsumed;

  /// No description provided for @macroProgressValue.
  ///
  /// In en, this message translates to:
  /// **'{consumed} / {target} g'**
  String macroProgressValue(int consumed, int target);

  /// No description provided for @macroRemaining.
  ///
  /// In en, this message translates to:
  /// **'{value} g left'**
  String macroRemaining(int value);

  /// No description provided for @macroOver.
  ///
  /// In en, this message translates to:
  /// **'{value} g over'**
  String macroOver(int value);

  /// No description provided for @unitGShort.
  ///
  /// In en, this message translates to:
  /// **'g'**
  String get unitGShort;

  /// No description provided for @mealBreakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get mealBreakfast;

  /// No description provided for @mealLunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get mealLunch;

  /// No description provided for @mealDinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get mealDinner;

  /// No description provided for @mealSnack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get mealSnack;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Your day'**
  String get dashboardTitle;

  /// No description provided for @dashboardAddMeal.
  ///
  /// In en, this message translates to:
  /// **'+ Add meal'**
  String get dashboardAddMeal;

  /// No description provided for @dashboardNoMeals.
  ///
  /// In en, this message translates to:
  /// **'No meals logged yet'**
  String get dashboardNoMeals;

  /// No description provided for @dashboardMissingProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete your health profile first so we can calculate your daily targets'**
  String get dashboardMissingProfile;

  /// No description provided for @dashboardMealDetails.
  ///
  /// In en, this message translates to:
  /// **'{grams} g · Protein {protein} · Carbs {carbs} · Fats {fats}'**
  String dashboardMealDetails(int grams, int protein, int carbs, int fats);

  /// No description provided for @dashboardMealDeleted.
  ///
  /// In en, this message translates to:
  /// **'Meal deleted'**
  String get dashboardMealDeleted;

  /// No description provided for @actionUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get actionUndo;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @addMealTitle.
  ///
  /// In en, this message translates to:
  /// **'Add meal'**
  String get addMealTitle;

  /// No description provided for @addMealCommonFoods.
  ///
  /// In en, this message translates to:
  /// **'Common foods'**
  String get addMealCommonFoods;

  /// No description provided for @addMealName.
  ///
  /// In en, this message translates to:
  /// **'Meal name'**
  String get addMealName;

  /// No description provided for @addMealType.
  ///
  /// In en, this message translates to:
  /// **'Meal type'**
  String get addMealType;

  /// No description provided for @addMealQuantity.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get addMealQuantity;

  /// No description provided for @addMealCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get addMealCalories;

  /// No description provided for @addMealSubmit.
  ///
  /// In en, this message translates to:
  /// **'Add to my day'**
  String get addMealSubmit;

  /// No description provided for @addMealPreviewRemaining.
  ///
  /// In en, this message translates to:
  /// **'You\'ll have {value} kcal left today'**
  String addMealPreviewRemaining(int value);

  /// No description provided for @addMealPreviewOver.
  ///
  /// In en, this message translates to:
  /// **'You\'ll exceed your target by {value} kcal'**
  String addMealPreviewOver(int value);

  /// No description provided for @foodBoiledEggs.
  ///
  /// In en, this message translates to:
  /// **'Boiled eggs'**
  String get foodBoiledEggs;

  /// No description provided for @foodGrilledChicken.
  ///
  /// In en, this message translates to:
  /// **'Grilled chicken breast'**
  String get foodGrilledChicken;

  /// No description provided for @foodWhiteRice.
  ///
  /// In en, this message translates to:
  /// **'Cooked white rice'**
  String get foodWhiteRice;

  /// No description provided for @foodArabicBread.
  ///
  /// In en, this message translates to:
  /// **'Pita bread'**
  String get foodArabicBread;

  /// No description provided for @foodOats.
  ///
  /// In en, this message translates to:
  /// **'Oats'**
  String get foodOats;

  /// No description provided for @foodYogurt.
  ///
  /// In en, this message translates to:
  /// **'Yogurt'**
  String get foodYogurt;

  /// No description provided for @foodFoul.
  ///
  /// In en, this message translates to:
  /// **'Foul medames'**
  String get foodFoul;

  /// No description provided for @foodHummus.
  ///
  /// In en, this message translates to:
  /// **'Hummus'**
  String get foodHummus;

  /// No description provided for @foodSalmon.
  ///
  /// In en, this message translates to:
  /// **'Salmon'**
  String get foodSalmon;

  /// No description provided for @foodSalad.
  ///
  /// In en, this message translates to:
  /// **'Green salad'**
  String get foodSalad;

  /// No description provided for @foodApple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get foodApple;

  /// No description provided for @foodBanana.
  ///
  /// In en, this message translates to:
  /// **'Banana'**
  String get foodBanana;

  /// No description provided for @foodDates.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get foodDates;

  /// No description provided for @foodAlmonds.
  ///
  /// In en, this message translates to:
  /// **'Almonds'**
  String get foodAlmonds;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get navTips;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @tipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Health tips'**
  String get tipsTitle;

  /// No description provided for @tipsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Science-based guidance that adapts to what you eat today'**
  String get tipsSubtitle;

  /// No description provided for @tipsSmartLabel.
  ///
  /// In en, this message translates to:
  /// **'Your smart tip right now'**
  String get tipsSmartLabel;

  /// No description provided for @tipsSectionToday.
  ///
  /// In en, this message translates to:
  /// **'Today\'s alerts'**
  String get tipsSectionToday;

  /// No description provided for @tipsSectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'Lose weight faster'**
  String get tipsSectionGeneral;

  /// No description provided for @tipCompleteProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete your health profile'**
  String get tipCompleteProfileTitle;

  /// No description provided for @tipCompleteProfileBody.
  ///
  /// In en, this message translates to:
  /// **'Enter your details in the \"Profile\" tab so we can calculate your targets and personalize your tips.'**
  String get tipCompleteProfileBody;

  /// No description provided for @tipProteinBreakfastTitle.
  ///
  /// In en, this message translates to:
  /// **'Start your day with protein'**
  String get tipProteinBreakfastTitle;

  /// No description provided for @tipProteinBreakfastBody.
  ///
  /// In en, this message translates to:
  /// **'A protein-rich breakfast like eggs or yogurt reduces hunger and random snacking throughout the day.'**
  String get tipProteinBreakfastBody;

  /// No description provided for @tipNoMealsTitle.
  ///
  /// In en, this message translates to:
  /// **'No meals logged yet'**
  String get tipNoMealsTitle;

  /// No description provided for @tipNoMealsBody.
  ///
  /// In en, this message translates to:
  /// **'Skipping meals increases hunger later and makes overeating more likely. Log a balanced meal now.'**
  String get tipNoMealsBody;

  /// No description provided for @tipOverCaloriesTitle.
  ///
  /// In en, this message translates to:
  /// **'You passed today\'s target'**
  String get tipOverCaloriesTitle;

  /// No description provided for @tipOverCaloriesBody.
  ///
  /// In en, this message translates to:
  /// **'That\'s okay, one day won\'t ruin your progress. Choose a light dinner of vegetables and protein, and add a 20-minute walk.'**
  String get tipOverCaloriesBody;

  /// No description provided for @tipLowProteinTitle.
  ///
  /// In en, this message translates to:
  /// **'Protein is below target'**
  String get tipLowProteinTitle;

  /// No description provided for @tipLowProteinBody.
  ///
  /// In en, this message translates to:
  /// **'Add a protein source to your next meal (chicken, fish, eggs, legumes). Protein preserves muscle and keeps you full.'**
  String get tipLowProteinBody;

  /// No description provided for @tipHighFatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Fats are over target'**
  String get tipHighFatsTitle;

  /// No description provided for @tipHighFatsBody.
  ///
  /// In en, this message translates to:
  /// **'Cut back on oils and fried food for the rest of the day, and choose grilling or boiling instead.'**
  String get tipHighFatsBody;

  /// No description provided for @tipHighCarbsTitle.
  ///
  /// In en, this message translates to:
  /// **'Carbs are over target'**
  String get tipHighCarbsTitle;

  /// No description provided for @tipHighCarbsBody.
  ///
  /// In en, this message translates to:
  /// **'Make your next meal vegetables with protein, and reduce bread, rice and sweets.'**
  String get tipHighCarbsBody;

  /// No description provided for @tipUnderEatingTitle.
  ///
  /// In en, this message translates to:
  /// **'You have eaten very little today'**
  String get tipUnderEatingTitle;

  /// No description provided for @tipUnderEatingBody.
  ///
  /// In en, this message translates to:
  /// **'A large deficit slows your metabolism and weakens muscle. Have a balanced meal to get closer to your target.'**
  String get tipUnderEatingBody;

  /// No description provided for @tipCloseToTargetTitle.
  ///
  /// In en, this message translates to:
  /// **'You are close to your target'**
  String get tipCloseToTargetTitle;

  /// No description provided for @tipCloseToTargetBody.
  ///
  /// In en, this message translates to:
  /// **'Great job! If you get hungry, choose a light snack like vegetables or yogurt.'**
  String get tipCloseToTargetBody;

  /// No description provided for @tipOnTrackTitle.
  ///
  /// In en, this message translates to:
  /// **'You are on track'**
  String get tipOnTrackTitle;

  /// No description provided for @tipOnTrackBody.
  ///
  /// In en, this message translates to:
  /// **'Your meals today are well balanced. Keep up the same pace.'**
  String get tipOnTrackBody;

  /// No description provided for @tipDrinkWaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Drink water'**
  String get tipDrinkWaterTitle;

  /// No description provided for @tipDrinkWaterBody.
  ///
  /// In en, this message translates to:
  /// **'Aim for at least 8 glasses a day. Thirst is sometimes mistaken for hunger.'**
  String get tipDrinkWaterBody;

  /// No description provided for @tipWalkingTitle.
  ///
  /// In en, this message translates to:
  /// **'Walk every day'**
  String get tipWalkingTitle;

  /// No description provided for @tipWalkingBody.
  ///
  /// In en, this message translates to:
  /// **'7,000 to 10,000 steps a day burn extra calories without strain and improve insulin sensitivity.'**
  String get tipWalkingBody;

  /// No description provided for @tipStrengthTitle.
  ///
  /// In en, this message translates to:
  /// **'Strength training'**
  String get tipStrengthTitle;

  /// No description provided for @tipStrengthBody.
  ///
  /// In en, this message translates to:
  /// **'Two to three sessions a week preserve muscle mass while losing weight and raise your calorie burn.'**
  String get tipStrengthBody;

  /// No description provided for @tipSleepTitle.
  ///
  /// In en, this message translates to:
  /// **'Sleep well'**
  String get tipSleepTitle;

  /// No description provided for @tipSleepBody.
  ///
  /// In en, this message translates to:
  /// **'7 to 9 hours of sleep regulate hunger and fullness hormones. Poor sleep increases sugar cravings.'**
  String get tipSleepBody;

  /// No description provided for @tipFiberTitle.
  ///
  /// In en, this message translates to:
  /// **'Eat more fiber'**
  String get tipFiberTitle;

  /// No description provided for @tipFiberBody.
  ///
  /// In en, this message translates to:
  /// **'Vegetables, legumes and oats fill your stomach with few calories and keep you full longer.'**
  String get tipFiberBody;

  /// No description provided for @tipProteinEveryMealTitle.
  ///
  /// In en, this message translates to:
  /// **'Protein in every meal'**
  String get tipProteinEveryMealTitle;

  /// No description provided for @tipProteinEveryMealBody.
  ///
  /// In en, this message translates to:
  /// **'Spreading protein across meals increases fullness, and your body uses more energy to digest it.'**
  String get tipProteinEveryMealBody;

  /// No description provided for @tipSugaryDrinksTitle.
  ///
  /// In en, this message translates to:
  /// **'Avoid sugary drinks'**
  String get tipSugaryDrinksTitle;

  /// No description provided for @tipSugaryDrinksBody.
  ///
  /// In en, this message translates to:
  /// **'Juices and soft drinks are liquid calories that don\'t fill you up. Replace them with water or unsweetened tea.'**
  String get tipSugaryDrinksBody;

  /// No description provided for @tipEatSlowlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Eat slowly'**
  String get tipEatSlowlyTitle;

  /// No description provided for @tipEatSlowlyBody.
  ///
  /// In en, this message translates to:
  /// **'Fullness signals take about 20 minutes to reach your brain. Slow down and chew well.'**
  String get tipEatSlowlyBody;

  /// No description provided for @tipWaterBeforeMealsTitle.
  ///
  /// In en, this message translates to:
  /// **'A glass of water before meals'**
  String get tipWaterBeforeMealsTitle;

  /// No description provided for @tipWaterBeforeMealsBody.
  ///
  /// In en, this message translates to:
  /// **'Drinking two glasses of water half an hour before a meal helps reduce how much you eat.'**
  String get tipWaterBeforeMealsBody;

  /// No description provided for @tipMoveMoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Move more during the day'**
  String get tipMoveMoreTitle;

  /// No description provided for @tipMoveMoreBody.
  ///
  /// In en, this message translates to:
  /// **'Take the stairs and stand during calls. Small daily movement burns more calories than you expect.'**
  String get tipMoveMoreBody;

  /// No description provided for @languageMenuLabel.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get languageMenuLabel;

  /// No description provided for @authWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get authWelcome;

  /// No description provided for @authSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync your progress across your devices'**
  String get authSubtitle;

  /// No description provided for @authEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignIn;

  /// No description provided for @authCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authCreateAccount;

  /// No description provided for @authGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authGoogle;

  /// No description provided for @authGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get authGuest;

  /// No description provided for @authOr.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get authOr;

  /// No description provided for @authLocalMode.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync is not set up yet. Your data will be saved on this device.'**
  String get authLocalMode;

  /// No description provided for @authErrorCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password'**
  String get authErrorCredentials;

  /// No description provided for @authErrorEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered'**
  String get authErrorEmailInUse;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get authErrorInvalidEmail;

  /// No description provided for @authErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again'**
  String get authErrorGeneric;

  /// No description provided for @actionSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get actionSignOut;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Your plan has been updated'**
  String get profileSaved;

  /// No description provided for @tipsViewAll.
  ///
  /// In en, this message translates to:
  /// **'All tips'**
  String get tipsViewAll;

  /// No description provided for @dashboardSwipeHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe a meal to delete it'**
  String get dashboardSwipeHint;

  /// No description provided for @loadErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your data'**
  String get loadErrorTitle;

  /// No description provided for @loadErrorBody.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection and try again.'**
  String get loadErrorBody;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionRetry;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
