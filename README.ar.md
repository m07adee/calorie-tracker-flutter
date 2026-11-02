<div align="center" dir="rtl">

# 🥗 حاسبة السعرات

**تطبيق ذكي متعدد اللغات لحساب السعرات والمغذيات وخسارة الوزن — مبني بـ Flutter وRiverpod وFirebase.**

[![CI](https://github.com/m07adee/calorie-tracker-flutter/actions/workflows/ci.yml/badge.svg)](https://github.com/m07adee/calorie-tracker-flutter/actions/workflows/ci.yml)
![Flutter](https://img.shields.io/badge/Flutter-3.47-02569B?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore-FFCA28?logo=firebase)
![Platform](https://img.shields.io/badge/platform-Android-3DDC84?logo=android)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

[English](README.md) · **العربية**

[⬇️ تحميل ملف APK](https://github.com/m07adee/calorie-tracker-flutter/releases/latest)

</div>

<div dir="rtl">

---

## المحتويات

- [المميزات](#المميزات)
- [التقنيات المستخدمة](#التقنيات-المستخدمة)
- [هيكل المشروع](#هيكل-المشروع)
- [التشغيل على جهازك](#التشغيل-على-جهازك)
- [ربط مشروع Firebase خاص بك](#ربط-مشروع-firebase-خاص-بك)
- [بناء نسخة APK](#بناء-نسخة-apk)
- [كيف تعدّل التطبيق](#كيف-تعدّل-التطبيق)
- [الترجمة وإضافة النصوص](#الترجمة-وإضافة-النصوص)
- [الاختبارات](#الاختبارات)
- [المساهمة](#المساهمة)

## المميزات

- 🧮 **حساب الاحتياج اليومي** بمعادلة **Mifflin-St Jeor**، ثم TDEE حسب 5 مستويات نشاط، مع عجز صحي 500 سعرة (وحد أدنى آمن 1200 سعرة للإناث و1500 للذكور).
- 🍗 **توزيع المغذيات:** بروتين 30% · كربوهيدرات 40% · دهون 30%، مع معاينة حية أثناء إدخال البيانات.
- 🍽️ **تسجيل الوجبات** في 4 فترات (فطور، غداء، عشاء، سناك) يدوياً أو بضغطة من 14 طعاماً شائعاً، مع إعادة الحساب تلقائياً حسب الكمية.
- 🎯 **شاشة رئيسية متحركة:** حلقة سعرات (المستهدف / المستهلك / المتبقي) وأشرطة للبروتين والكارب والدهون، وحذف الوجبة بالسحب مع إمكانية التراجع.
- 💡 **محرك نصائح ذكي** يتغير حسب ما أكلته اليوم (نقص البروتين، تجاوز الهدف، شرب الماء…) مع نصائح علمية لتسريع خسارة الوزن.
- 🌍 **3 لغات بتبديل فوري:** العربية (من اليمين لليسار)، والتركية والإنجليزية، بضغطة واحدة ودون إعادة التشغيل.
- 🔐 **تسجيل دخول مرن:** بالبريد الإلكتروني، أو حساب Google، أو كضيف. وتبقى بيانات الضيف عند إنشائه حساباً.
- ☁️ **مزامنة سحابية وعمل بدون إنترنت** عبر Cloud Firestore. وإذا لم يكن Firebase مربوطاً يعمل التطبيق تلقائياً بالتخزين على الجهاز.
- 🌗 **تصميم Material 3** بوضعين نهاري وليلي.

## التقنيات المستخدمة

| الطبقة | التقنية |
|---|---|
| الواجهة | Flutter وMaterial 3 وحركات `CustomPainter` |
| إدارة الحالة | [Riverpod 3](https://riverpod.dev) |
| تسجيل الدخول | `firebase_auth` و`google_sign_in` |
| قاعدة البيانات | `cloud_firestore` مع العمل بدون إنترنت، و`shared_preferences` للتخزين المحلي واللغة |
| الترجمة | `flutter_localizations` و`intl` وملفات ARB |

## هيكل المشروع

```text
lib/
├── core/          # الثيم والألوان، والنصوص المترجمة، وزر تبديل اللغة
├── data/          # المستودعات (تسجيل الدخول والتغذية) وتهيئة Firebase
├── domain/        # النماذج، وحاسبة السعرات، والأطعمة الشائعة، ومحرك النصائح
├── features/      # الشاشات: الدخول، الملف الصحي، الرئيسية، إضافة وجبة، النصائح، التنقل
├── l10n/          # ملفات الترجمة الثلاثة
├── providers/     # مزودات Riverpod
└── main.dart
```

**مسار البيانات:** `الشاشات ← مزودات Riverpod ← المستودعات ← Firestore (أو التخزين المحلي)`.
في Firestore: الملف الصحي والأهداف في `users/{uid}`، والوجبات في `users/{uid}/meals/{mealId}`.

## التشغيل على جهازك

### المتطلبات

- [Flutter SDK](https://docs.flutter.dev/get-started/install) **إصدار 3.47 أو أحدث**
- Android SDK (عبر Android Studio أو أدوات سطر الأوامر) و**JDK 17**
- هاتف أندرويد أو محاكٍ

### الخطوات

</div>

```bash
git clone https://github.com/m07adee/calorie-tracker-flutter.git
cd calorie-tracker-flutter
flutter pub get
flutter run
```

<div dir="rtl">

> **لا تملك مشروع Firebase؟** لا مشكلة. إذا لم يوجد ملف `android/app/google-services.json` يعمل التطبيق **بالوضع المحلي**: تدخل كضيف وتُحفظ بياناتك على الجهاز. ويتفعّل الدخول بالبريد وGoogle بعد ربط Firebase.

## ربط مشروع Firebase خاص بك

1. أنشئ مشروعاً في [Firebase Console](https://console.firebase.google.com).
2. أضف **تطبيق Android** باسم الحزمة `com.health.calorie_tracker`.
3. استخرج بصمتي SHA-1 وSHA-256 لمفتاح التوقيع وأضفهما في إعدادات التطبيق (مطلوبة لتسجيل الدخول بـ Google):

</div>

```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

<div dir="rtl">

4. من **Authentication ← Sign-in method** فعّل: **Anonymous** و**Email/Password** و**Google**.
5. من **Firestore Database** أنشئ قاعدة البيانات، ثم انشر قواعد الحماية الموجودة في ملف [`firestore.rules`](firestore.rules)، وهي تسمح لكل مستخدم بقراءة بياناته فقط:

</div>

```bash
firebase deploy --only firestore:rules --project <your-project-id>
```

<div dir="rtl">

6. نزّل ملف `google-services.json` (بعد إضافة البصمات) وضعه في `android/app/google-services.json`.

يتفعّل Firebase **تلقائياً** عند وجود الملف دون أي تعديل في الكود.

> ملف `google-services.json` مستثنى من المستودع عمداً، لأن كل مطوّر يستخدم مشروع Firebase الخاص به.

## بناء نسخة APK

</div>

```bash
flutter build apk --release
# ملفات أصغر لكل نوع معالج:
flutter build apk --release --split-per-abi
```

<div dir="rtl">

الملف الناتج في `build/app/outputs/flutter-apk/`.
نسخة الإصدار موقّعة حالياً بمفتاح debug (في `android/app/build.gradle.kts`) لتسهيل مشاركتها. قبل النشر على Google Play [أنشئ مفتاح توقيع خاصاً](https://docs.flutter.dev/deployment/android#sign-the-app) وأضف بصمته في Firebase.

## كيف تعدّل التطبيق

| أريد تعديل… | الملف |
|---|---|
| معادلة السعرات أو العجز أو نسب المغذيات | `lib/domain/calculator/calorie_macro_calculator.dart` |
| معاملات مستوى النشاط | `lib/domain/models/activity_level.dart` |
| قائمة الأطعمة الشائعة وقيمها | `lib/domain/foods/common_foods.dart` (والأسماء في ملفات الترجمة) |
| متى تظهر النصائح الذكية | `lib/domain/tips/smart_tips_engine.dart` |
| ألوان التطبيق والمغذيات | `lib/core/theme/app_theme.dart` و`nutrient_colors.dart` |
| أي نص يظهر في التطبيق | `lib/l10n/app_en.arb` و`app_ar.arb` و`app_tr.arb` |
| هيكل قاعدة البيانات | `lib/data/repositories/nutrition_repository.dart` و`firestore.rules` |

## الترجمة وإضافة النصوص

كل نصوص الواجهة موجودة في ملفات ARB، **ولا تُكتب النصوص مباشرة داخل كود Dart**.

1. أضف المفتاح الجديد إلى **الملفات الثلاثة**: `app_en.arb` (الملف الأساسي) و`app_ar.arb` و`app_tr.arb`.
2. ولّد كلاس الترجمة بأمر `flutter gen-l10n`.
3. استخدمه في الواجهة: `AppLocalizations.of(context).yourKey`.

لإضافة لغة جديدة أنشئ ملف `app_<code>.arb` وأضف اللغة إلى `AppLanguage` في `lib/providers/locale_provider.dart`.

## الاختبارات

</div>

```bash
flutter analyze
flutter test
```

<div dir="rtl">

تغطي الاختبارات رحلة الضيف كاملة (الدخول ← الملف الصحي ← الرئيسية ← إضافة وجبة)، وشاشة الخطأ عند تعذّر تحميل البيانات. ويتحقق [GitHub Actions](.github/workflows/ci.yml) منهما تلقائياً مع كل تعديل.

## المساهمة

المساهمات مرحّب بها! اقرأ [CONTRIBUTING.md](CONTRIBUTING.md) قبل فتح Pull Request.

## تنبيه

يقدّم التطبيق تقديرات غذائية عامة لأغراض تعليمية، **وليس بديلاً عن الاستشارة الطبية**. استشر مختصاً قبل البدء بأي نظام غذائي.

## الترخيص

المشروع منشور تحت [رخصة MIT](LICENSE).

</div>
