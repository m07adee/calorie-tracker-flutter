// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'حاسبة السعرات';

  @override
  String get onboardingTitle => 'لنبدأ رحلتك الصحية';

  @override
  String get onboardingSubtitle => 'أدخل بياناتك وسنحسب احتياجك اليومي فوراً';

  @override
  String get onboardingSectionGender => 'الجنس';

  @override
  String get onboardingSectionBody => 'قياسات الجسم';

  @override
  String get onboardingSectionActivity => 'مستوى النشاط اليومي';

  @override
  String get genderMale => 'ذكر';

  @override
  String get genderFemale => 'أنثى';

  @override
  String get labelAge => 'العمر';

  @override
  String get labelHeight => 'الطول';

  @override
  String get labelWeight => 'الوزن الحالي';

  @override
  String get labelTargetWeight => 'الوزن المستهدف';

  @override
  String get unitYears => 'سنة';

  @override
  String get unitCm => 'سم';

  @override
  String get unitKg => 'كغ';

  @override
  String get unitKcal => 'سعرة';

  @override
  String unitGrams(int value) {
    return '$value غ';
  }

  @override
  String unitKcalValue(int value) {
    return '$value سعرة';
  }

  @override
  String get activitySedentary => 'خامل';

  @override
  String get activitySedentaryDesc => 'عمل مكتبي وحركة قليلة';

  @override
  String get activityLight => 'خفيف';

  @override
  String get activityLightDesc => 'تمارين خفيفة ١-٣ أيام أسبوعياً';

  @override
  String get activityModerate => 'متوسط';

  @override
  String get activityModerateDesc => 'تمارين متوسطة ٣-٥ أيام أسبوعياً';

  @override
  String get activityHigh => 'عالي';

  @override
  String get activityHighDesc => 'تمارين قوية ٦-٧ أيام أسبوعياً';

  @override
  String get activityExtreme => 'فائق';

  @override
  String get activityExtremeDesc => 'عمل بدني شاق أو تمرين مرتين يومياً';

  @override
  String get resultDailyCalories => 'السعرات اليومية المستهدفة';

  @override
  String resultBmr(int value) {
    return 'الأيض الأساسي: $value';
  }

  @override
  String resultTdee(int value) {
    return 'الاستهلاك اليومي: $value';
  }

  @override
  String get macroProtein => 'البروتين';

  @override
  String get macroCarbs => 'الكربوهيدرات';

  @override
  String get macroFats => 'الدهون';

  @override
  String get actionSaveStart => 'احفظ وابدأ';

  @override
  String get ringRemaining => 'سعرة متبقية';

  @override
  String get ringOver => 'سعرة زائدة';

  @override
  String get ringTarget => 'المستهدف';

  @override
  String get ringConsumed => 'المستهلك';

  @override
  String macroProgressValue(int consumed, int target) {
    return '$consumed / $target غ';
  }

  @override
  String macroRemaining(int value) {
    return 'متبقي $value غ';
  }

  @override
  String macroOver(int value) {
    return 'زيادة $value غ';
  }

  @override
  String get unitGShort => 'غ';

  @override
  String get mealBreakfast => 'فطور';

  @override
  String get mealLunch => 'غداء';

  @override
  String get mealDinner => 'عشاء';

  @override
  String get mealSnack => 'سناك';

  @override
  String get dashboardTitle => 'يومك اليوم';

  @override
  String get dashboardAddMeal => '+ إضافة وجبة';

  @override
  String get dashboardNoMeals => 'لم تُسجَّل وجبات بعد';

  @override
  String get dashboardMissingProfile =>
      'أكمل بياناتك الصحية أولاً لنحسب أهدافك اليومية';

  @override
  String dashboardMealDetails(int grams, int protein, int carbs, int fats) {
    return '$grams غ · بروتين $protein · كارب $carbs · دهون $fats';
  }

  @override
  String get dashboardMealDeleted => 'تم حذف الوجبة';

  @override
  String get actionUndo => 'تراجع';

  @override
  String get actionDelete => 'حذف';

  @override
  String get addMealTitle => 'إضافة وجبة';

  @override
  String get addMealCommonFoods => 'أطعمة شائعة';

  @override
  String get addMealName => 'اسم الوجبة';

  @override
  String get addMealType => 'نوع الوجبة';

  @override
  String get addMealQuantity => 'الكمية';

  @override
  String get addMealCalories => 'السعرات';

  @override
  String get addMealSubmit => 'أضف إلى يومي';

  @override
  String addMealPreviewRemaining(int value) {
    return 'سيتبقى لك $value سعرة اليوم';
  }

  @override
  String addMealPreviewOver(int value) {
    return 'ستتجاوز هدفك بـ $value سعرة';
  }

  @override
  String get foodBoiledEggs => 'بيض مسلوق';

  @override
  String get foodGrilledChicken => 'صدر دجاج مشوي';

  @override
  String get foodWhiteRice => 'أرز أبيض مطبوخ';

  @override
  String get foodArabicBread => 'خبز عربي';

  @override
  String get foodOats => 'شوفان';

  @override
  String get foodYogurt => 'لبن زبادي';

  @override
  String get foodFoul => 'فول مدمس';

  @override
  String get foodHummus => 'حمص بالطحينة';

  @override
  String get foodSalmon => 'سلمون';

  @override
  String get foodSalad => 'سلطة خضار';

  @override
  String get foodApple => 'تفاح';

  @override
  String get foodBanana => 'موز';

  @override
  String get foodDates => 'تمر';

  @override
  String get foodAlmonds => 'لوز';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navTips => 'النصائح';

  @override
  String get navProfile => 'ملفي';

  @override
  String get tipsTitle => 'نصائح صحية';

  @override
  String get tipsSubtitle => 'إرشادات علمية تتكيف مع ما تأكله اليوم';

  @override
  String get tipsSmartLabel => 'نصيحتك الذكية الآن';

  @override
  String get tipsSectionToday => 'تنبيهات اليوم';

  @override
  String get tipsSectionGeneral => 'لتسريع خسارة الوزن';

  @override
  String get tipCompleteProfileTitle => 'أكمل ملفك الصحي';

  @override
  String get tipCompleteProfileBody =>
      'أدخل بياناتك من تبويب \"ملفي\" لنحسب أهدافك ونخصص لك النصائح.';

  @override
  String get tipProteinBreakfastTitle => 'ابدأ يومك ببروتين';

  @override
  String get tipProteinBreakfastBody =>
      'فطور غني بالبروتين مثل البيض أو الزبادي يقلل الجوع ويخفف الأكل العشوائي خلال اليوم.';

  @override
  String get tipNoMealsTitle => 'لم تسجل أي وجبة بعد';

  @override
  String get tipNoMealsBody =>
      'تجاهل الوجبات يرفع الجوع لاحقاً ويزيد احتمال الإفراط. سجّل وجبة متوازنة الآن.';

  @override
  String get tipOverCaloriesTitle => 'تجاوزت هدف اليوم';

  @override
  String get tipOverCaloriesBody =>
      'لا بأس، يوم واحد لا يفسد التقدم. اختر عشاءً خفيفاً من الخضار والبروتين، وأضف مشياً لمدة ٢٠ دقيقة.';

  @override
  String get tipLowProteinTitle => 'البروتين أقل من المطلوب';

  @override
  String get tipLowProteinBody =>
      'أضف مصدر بروتين لوجبتك القادمة (دجاج، سمك، بيض، بقوليات). البروتين يحافظ على العضلات ويزيد الشبع.';

  @override
  String get tipHighFatsTitle => 'الدهون تجاوزت هدفها';

  @override
  String get tipHighFatsBody =>
      'قلّل الزيوت والمقليات في بقية اليوم، واختر الشوي أو السلق بدلاً منها.';

  @override
  String get tipHighCarbsTitle => 'الكربوهيدرات تجاوزت هدفها';

  @override
  String get tipHighCarbsBody =>
      'اجعل وجبتك القادمة خضاراً مع بروتين، وقلّل الخبز والأرز والحلويات.';

  @override
  String get tipUnderEatingTitle => 'أكلك اليوم قليل جداً';

  @override
  String get tipUnderEatingBody =>
      'العجز الكبير يبطئ الحرق ويضعف العضلات. تناول وجبة متوازنة تقترب بها من هدفك.';

  @override
  String get tipCloseToTargetTitle => 'أنت قريب من هدفك';

  @override
  String get tipCloseToTargetBody =>
      'ممتاز! إن جعت فاختر سناكاً خفيفاً مثل الخضار أو الزبادي.';

  @override
  String get tipOnTrackTitle => 'أنت على المسار الصحيح';

  @override
  String get tipOnTrackBody => 'توزيع وجباتك اليوم متوازن. استمر بنفس الوتيرة.';

  @override
  String get tipDrinkWaterTitle => 'اشرب الماء';

  @override
  String get tipDrinkWaterBody =>
      'احرص على ٨ أكواب يومياً على الأقل. العطش يُخلط أحياناً بالجوع.';

  @override
  String get tipWalkingTitle => 'امشِ يومياً';

  @override
  String get tipWalkingBody =>
      '٧٠٠٠ إلى ١٠٠٠٠ خطوة يومياً تحرق سعرات إضافية دون إجهاد وتحسن حساسية الإنسولين.';

  @override
  String get tipStrengthTitle => 'تمارين المقاومة';

  @override
  String get tipStrengthBody =>
      'مرتان إلى ثلاث أسبوعياً تحافظ على الكتلة العضلية أثناء خسارة الوزن وترفع معدل الحرق.';

  @override
  String get tipSleepTitle => 'نم جيداً';

  @override
  String get tipSleepBody =>
      'النوم من ٧ إلى ٩ ساعات ينظم هرمونات الجوع والشبع. قلة النوم تزيد الرغبة في السكريات.';

  @override
  String get tipFiberTitle => 'أكثر من الألياف';

  @override
  String get tipFiberBody =>
      'الخضار والبقوليات والشوفان تملأ المعدة بسعرات قليلة وتطيل الشبع.';

  @override
  String get tipProteinEveryMealTitle => 'بروتين في كل وجبة';

  @override
  String get tipProteinEveryMealBody =>
      'توزيع البروتين على الوجبات يرفع الشبع، ويستهلك الجسم طاقة أكبر لهضمه.';

  @override
  String get tipSugaryDrinksTitle => 'تجنب المشروبات المحلاة';

  @override
  String get tipSugaryDrinksBody =>
      'العصائر والمشروبات الغازية سعرات سائلة لا تُشبع. استبدلها بالماء أو الشاي دون سكر.';

  @override
  String get tipEatSlowlyTitle => 'كل ببطء';

  @override
  String get tipEatSlowlyBody =>
      'إشارات الشبع تحتاج نحو ٢٠ دقيقة لتصل للدماغ. تمهّل وامضغ جيداً.';

  @override
  String get tipWaterBeforeMealsTitle => 'كوب ماء قبل الوجبة';

  @override
  String get tipWaterBeforeMealsBody =>
      'شرب كوبين من الماء قبل الوجبة بنصف ساعة يساعد على تقليل الكمية المتناولة.';

  @override
  String get tipMoveMoreTitle => 'تحرك أكثر خلال اليوم';

  @override
  String get tipMoveMoreBody =>
      'استخدم الدرج وقف أثناء المكالمات. الحركة اليومية البسيطة تحرق سعرات أكثر مما تتوقع.';

  @override
  String get languageMenuLabel => 'تغيير اللغة';

  @override
  String get authWelcome => 'أهلاً بك';

  @override
  String get authSubtitle => 'سجّل دخولك لمزامنة تقدمك بين أجهزتك';

  @override
  String get authEmail => 'البريد الإلكتروني';

  @override
  String get authPassword => 'كلمة المرور';

  @override
  String get authSignIn => 'تسجيل الدخول';

  @override
  String get authCreateAccount => 'إنشاء حساب';

  @override
  String get authGoogle => 'المتابعة بحساب Google';

  @override
  String get authGuest => 'المتابعة كضيف';

  @override
  String get authOr => 'أو';

  @override
  String get authLocalMode =>
      'المزامنة السحابية غير مفعّلة بعد، وستُحفظ بياناتك على هذا الجهاز.';

  @override
  String get authErrorCredentials => 'البريد أو كلمة المرور غير صحيحة';

  @override
  String get authErrorEmailInUse => 'هذا البريد مسجّل مسبقاً';

  @override
  String get authErrorWeakPassword => 'يجب ألا تقل كلمة المرور عن 6 أحرف';

  @override
  String get authErrorInvalidEmail => 'أدخل بريداً إلكترونياً صحيحاً';

  @override
  String get authErrorGeneric => 'حدث خطأ، حاول مرة أخرى';

  @override
  String get actionSignOut => 'تسجيل الخروج';

  @override
  String get profileSaved => 'تم تحديث خطتك';

  @override
  String get tipsViewAll => 'كل النصائح';

  @override
  String get dashboardSwipeHint => 'اسحب الوجبة لحذفها';

  @override
  String get loadErrorTitle => 'تعذّر تحميل بياناتك';

  @override
  String get loadErrorBody => 'تحقق من اتصالك بالإنترنت ثم حاول مرة أخرى.';

  @override
  String get actionRetry => 'إعادة المحاولة';
}
