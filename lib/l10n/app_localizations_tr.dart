// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'Kalori Takibi';

  @override
  String get onboardingTitle => 'Sağlık yolculuğuna başlayalım';

  @override
  String get onboardingSubtitle =>
      'Bilgilerini gir, günlük ihtiyacını hemen hesaplayalım';

  @override
  String get onboardingSectionGender => 'Cinsiyet';

  @override
  String get onboardingSectionBody => 'Vücut ölçüleri';

  @override
  String get onboardingSectionActivity => 'Günlük aktivite seviyesi';

  @override
  String get genderMale => 'Erkek';

  @override
  String get genderFemale => 'Kadın';

  @override
  String get labelAge => 'Yaş';

  @override
  String get labelHeight => 'Boy';

  @override
  String get labelWeight => 'Mevcut kilo';

  @override
  String get labelTargetWeight => 'Hedef kilo';

  @override
  String get unitYears => 'yaş';

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
  String get activitySedentary => 'Hareketsiz';

  @override
  String get activitySedentaryDesc => 'Masa başı iş ve az hareket';

  @override
  String get activityLight => 'Hafif';

  @override
  String get activityLightDesc => 'Haftada 1-3 gün hafif egzersiz';

  @override
  String get activityModerate => 'Orta';

  @override
  String get activityModerateDesc => 'Haftada 3-5 gün orta egzersiz';

  @override
  String get activityHigh => 'Yüksek';

  @override
  String get activityHighDesc => 'Haftada 6-7 gün yoğun egzersiz';

  @override
  String get activityExtreme => 'Çok yüksek';

  @override
  String get activityExtremeDesc => 'Ağır fiziksel iş veya günde iki antrenman';

  @override
  String get resultDailyCalories => 'Günlük kalori hedefi';

  @override
  String resultBmr(int value) {
    return 'Bazal metabolizma: $value';
  }

  @override
  String resultTdee(int value) {
    return 'Günlük harcama: $value';
  }

  @override
  String get macroProtein => 'Protein';

  @override
  String get macroCarbs => 'Karbonhidrat';

  @override
  String get macroFats => 'Yağ';

  @override
  String get actionSaveStart => 'Kaydet ve başla';

  @override
  String get ringRemaining => 'kcal kaldı';

  @override
  String get ringOver => 'kcal fazla';

  @override
  String get ringTarget => 'Hedef';

  @override
  String get ringConsumed => 'Alınan';

  @override
  String macroProgressValue(int consumed, int target) {
    return '$consumed / $target g';
  }

  @override
  String macroRemaining(int value) {
    return '$value g kaldı';
  }

  @override
  String macroOver(int value) {
    return '$value g fazla';
  }

  @override
  String get unitGShort => 'g';

  @override
  String get mealBreakfast => 'Kahvaltı';

  @override
  String get mealLunch => 'Öğle yemeği';

  @override
  String get mealDinner => 'Akşam yemeği';

  @override
  String get mealSnack => 'Ara öğün';

  @override
  String get dashboardTitle => 'Bugünün';

  @override
  String get dashboardAddMeal => '+ Öğün ekle';

  @override
  String get dashboardNoMeals => 'Henüz öğün eklenmedi';

  @override
  String get dashboardMissingProfile =>
      'Günlük hedeflerini hesaplayabilmemiz için önce sağlık profilini tamamla';

  @override
  String dashboardMealDetails(int grams, int protein, int carbs, int fats) {
    return '$grams g · Protein $protein · Karb. $carbs · Yağ $fats';
  }

  @override
  String get dashboardMealDeleted => 'Öğün silindi';

  @override
  String get actionUndo => 'Geri al';

  @override
  String get actionDelete => 'Sil';

  @override
  String get addMealTitle => 'Öğün ekle';

  @override
  String get addMealCommonFoods => 'Sık kullanılan yiyecekler';

  @override
  String get addMealName => 'Öğün adı';

  @override
  String get addMealType => 'Öğün türü';

  @override
  String get addMealQuantity => 'Miktar';

  @override
  String get addMealCalories => 'Kalori';

  @override
  String get addMealSubmit => 'Günüme ekle';

  @override
  String addMealPreviewRemaining(int value) {
    return 'Bugün $value kcal hakkın kalacak';
  }

  @override
  String addMealPreviewOver(int value) {
    return 'Hedefini $value kcal aşacaksın';
  }

  @override
  String get foodBoiledEggs => 'Haşlanmış yumurta';

  @override
  String get foodGrilledChicken => 'Izgara tavuk göğsü';

  @override
  String get foodWhiteRice => 'Pişmiş beyaz pirinç';

  @override
  String get foodArabicBread => 'Pide ekmeği';

  @override
  String get foodOats => 'Yulaf';

  @override
  String get foodYogurt => 'Yoğurt';

  @override
  String get foodFoul => 'Bakla ezmesi (ful)';

  @override
  String get foodHummus => 'Humus';

  @override
  String get foodSalmon => 'Somon';

  @override
  String get foodSalad => 'Yeşil salata';

  @override
  String get foodApple => 'Elma';

  @override
  String get foodBanana => 'Muz';

  @override
  String get foodDates => 'Hurma';

  @override
  String get foodAlmonds => 'Badem';

  @override
  String get navHome => 'Ana sayfa';

  @override
  String get navTips => 'İpuçları';

  @override
  String get navProfile => 'Profilim';

  @override
  String get tipsTitle => 'Sağlık ipuçları';

  @override
  String get tipsSubtitle =>
      'Bugün yediklerine göre uyarlanan bilimsel öneriler';

  @override
  String get tipsSmartLabel => 'Şu anki akıllı ipucun';

  @override
  String get tipsSectionToday => 'Bugünün uyarıları';

  @override
  String get tipsSectionGeneral => 'Daha hızlı kilo vermek için';

  @override
  String get tipCompleteProfileTitle => 'Sağlık profilini tamamla';

  @override
  String get tipCompleteProfileBody =>
      'Hedeflerini hesaplayıp ipuçlarını kişiselleştirebilmemiz için \"Profilim\" sekmesinden bilgilerini gir.';

  @override
  String get tipProteinBreakfastTitle => 'Güne proteinle başla';

  @override
  String get tipProteinBreakfastBody =>
      'Yumurta veya yoğurt gibi proteinli bir kahvaltı açlığı azaltır ve gün içindeki rastgele atıştırmaları önler.';

  @override
  String get tipNoMealsTitle => 'Henüz öğün eklemedin';

  @override
  String get tipNoMealsBody =>
      'Öğün atlamak sonradan açlığı artırır ve aşırı yeme ihtimalini yükseltir. Şimdi dengeli bir öğün ekle.';

  @override
  String get tipOverCaloriesTitle => 'Bugünkü hedefini aştın';

  @override
  String get tipOverCaloriesBody =>
      'Sorun değil, tek bir gün ilerlemeni bozmaz. Sebze ve proteinden hafif bir akşam yemeği seç ve 20 dakika yürüyüş ekle.';

  @override
  String get tipLowProteinTitle => 'Protein hedefin altında';

  @override
  String get tipLowProteinBody =>
      'Bir sonraki öğününe protein kaynağı ekle (tavuk, balık, yumurta, baklagiller). Protein kasları korur ve tok tutar.';

  @override
  String get tipHighFatsTitle => 'Yağ hedefini aştı';

  @override
  String get tipHighFatsBody =>
      'Günün geri kalanında yağları ve kızartmaları azalt, bunun yerine ızgara veya haşlama tercih et.';

  @override
  String get tipHighCarbsTitle => 'Karbonhidrat hedefini aştı';

  @override
  String get tipHighCarbsBody =>
      'Bir sonraki öğününü proteinli sebzelerden oluştur; ekmek, pirinç ve tatlıyı azalt.';

  @override
  String get tipUnderEatingTitle => 'Bugün çok az yedin';

  @override
  String get tipUnderEatingBody =>
      'Büyük kalori açığı metabolizmayı yavaşlatır ve kasları zayıflatır. Hedefine yaklaşmak için dengeli bir öğün ye.';

  @override
  String get tipCloseToTargetTitle => 'Hedefine çok yakınsın';

  @override
  String get tipCloseToTargetBody =>
      'Harika! Acıkırsan sebze veya yoğurt gibi hafif bir ara öğün seç.';

  @override
  String get tipOnTrackTitle => 'Doğru yoldasın';

  @override
  String get tipOnTrackBody =>
      'Bugünkü öğünlerin dengeli. Aynı tempoda devam et.';

  @override
  String get tipDrinkWaterTitle => 'Su iç';

  @override
  String get tipDrinkWaterBody =>
      'Günde en az 8 bardak su içmeye özen göster. Susuzluk bazen açlıkla karıştırılır.';

  @override
  String get tipWalkingTitle => 'Her gün yürü';

  @override
  String get tipWalkingBody =>
      'Günde 7.000 ile 10.000 adım, yorulmadan ekstra kalori yakar ve insülin duyarlılığını artırır.';

  @override
  String get tipStrengthTitle => 'Direnç egzersizleri';

  @override
  String get tipStrengthBody =>
      'Haftada iki-üç seans, kilo verirken kas kütlesini korur ve kalori yakımını artırır.';

  @override
  String get tipSleepTitle => 'İyi uyu';

  @override
  String get tipSleepBody =>
      '7-9 saat uyku açlık ve tokluk hormonlarını düzenler. Uykusuzluk şeker isteğini artırır.';

  @override
  String get tipFiberTitle => 'Daha fazla lif tüket';

  @override
  String get tipFiberBody =>
      'Sebzeler, baklagiller ve yulaf az kaloriyle mideyi doldurur ve tokluğu uzatır.';

  @override
  String get tipProteinEveryMealTitle => 'Her öğünde protein';

  @override
  String get tipProteinEveryMealBody =>
      'Proteini öğünlere yaymak tokluğu artırır ve vücut onu sindirmek için daha fazla enerji harcar.';

  @override
  String get tipSugaryDrinksTitle => 'Şekerli içeceklerden kaçın';

  @override
  String get tipSugaryDrinksBody =>
      'Meyve suları ve gazlı içecekler doyurmayan sıvı kalorilerdir. Yerine su veya şekersiz çay iç.';

  @override
  String get tipEatSlowlyTitle => 'Yavaş ye';

  @override
  String get tipEatSlowlyBody =>
      'Tokluk sinyallerinin beyne ulaşması yaklaşık 20 dakika sürer. Yavaşla ve iyi çiğne.';

  @override
  String get tipWaterBeforeMealsTitle => 'Yemekten önce bir bardak su';

  @override
  String get tipWaterBeforeMealsBody =>
      'Yemekten yarım saat önce iki bardak su içmek yenen miktarı azaltmaya yardımcı olur.';

  @override
  String get tipMoveMoreTitle => 'Gün içinde daha çok hareket et';

  @override
  String get tipMoveMoreBody =>
      'Merdiven kullan ve telefonda konuşurken ayakta dur. Küçük günlük hareketler sandığından fazla kalori yakar.';

  @override
  String get languageMenuLabel => 'Dili değiştir';

  @override
  String get authWelcome => 'Hoş geldin';

  @override
  String get authSubtitle =>
      'İlerlemeni cihazların arasında eşitlemek için giriş yap';

  @override
  String get authEmail => 'E-posta';

  @override
  String get authPassword => 'Şifre';

  @override
  String get authSignIn => 'Giriş yap';

  @override
  String get authCreateAccount => 'Hesap oluştur';

  @override
  String get authGoogle => 'Google ile devam et';

  @override
  String get authGuest => 'Misafir olarak devam et';

  @override
  String get authOr => 'veya';

  @override
  String get authLocalMode =>
      'Bulut eşitleme henüz kurulmadı. Verilerin bu cihazda saklanacak.';

  @override
  String get authErrorCredentials => 'E-posta veya şifre hatalı';

  @override
  String get authErrorEmailInUse => 'Bu e-posta zaten kayıtlı';

  @override
  String get authErrorWeakPassword => 'Şifre en az 6 karakter olmalı';

  @override
  String get authErrorInvalidEmail => 'Geçerli bir e-posta gir';

  @override
  String get authErrorGeneric => 'Bir şeyler ters gitti, tekrar dene';

  @override
  String get actionSignOut => 'Çıkış yap';

  @override
  String get profileSaved => 'Planın güncellendi';

  @override
  String get tipsViewAll => 'Tüm ipuçları';

  @override
  String get dashboardSwipeHint => 'Silmek için öğünü kaydır';

  @override
  String get loadErrorTitle => 'Verilerin yüklenemedi';

  @override
  String get loadErrorBody => 'İnternet bağlantını kontrol edip tekrar dene.';

  @override
  String get actionRetry => 'Tekrar dene';
}
