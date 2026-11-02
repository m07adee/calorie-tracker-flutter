<div align="center">

# 🥗 Calorie Tracker

**A smart, multilingual calorie & macro tracker for weight loss — built with Flutter, Riverpod and Firebase.**

[![CI](https://github.com/m07adee/calorie-tracker-flutter/actions/workflows/ci.yml/badge.svg)](https://github.com/m07adee/calorie-tracker-flutter/actions/workflows/ci.yml)
![Flutter](https://img.shields.io/badge/Flutter-3.47-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3-0175C2?logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore-FFCA28?logo=firebase)
![Platform](https://img.shields.io/badge/platform-Android-3DDC84?logo=android)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**English** · [العربية](README.ar.md)

[⬇️ Download the APK](https://github.com/m07adee/calorie-tracker-flutter/releases/latest)

</div>

---

## Table of contents

- [Features](#features)
- [Tech stack](#tech-stack)
- [Project structure](#project-structure)
- [Getting started](#getting-started)
- [Connecting your own Firebase project](#connecting-your-own-firebase-project)
- [Building a release APK](#building-a-release-apk)
- [How to customize the app](#how-to-customize-the-app)
- [Localization](#localization)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Features

| | |
|---|---|
| 🧮 **Daily needs calculator** | BMR with the **Mifflin-St Jeor** equation, TDEE from 5 activity levels, a safe 500 kcal deficit (minimum 1200 kcal for women / 1500 kcal for men). |
| 🍗 **Macro split** | Protein 30% · Carbs 40% · Fats 30% (4 / 4 / 9 kcal per gram), with a live preview while you type. |
| 🍽️ **Meal logging** | Breakfast, lunch, dinner and snacks. Manual entry or one tap from 14 common foods, with automatic re-calculation by quantity. |
| 🎯 **Animated dashboard** | Animated calorie ring (target / eaten / remaining) and progress bars for protein, carbs and fats. Swipe to delete with undo. |
| 💡 **Smart tips engine** | A tip card that adapts to what you ate today (low protein, over target, drink water…) plus science-based weight-loss tips. |
| 🌍 **3 languages, instant switch** | Arabic (RTL), Turkish and English (LTR) — switched with one tap, no restart. |
| 🔐 **Flexible sign-in** | Email/password, Google, or continue as a guest. Guest data is kept when the guest creates an account. |
| ☁️ **Cloud sync + offline** | Cloud Firestore with offline persistence. Without Firebase configured, the app automatically falls back to on-device storage. |
| 🌗 **Material 3** | Modern light & dark themes with dedicated nutrient colors. |

## Tech stack

| Layer | Technology |
|---|---|
| UI | Flutter, Material 3, `CustomPainter` animations |
| State management | [Riverpod 3](https://riverpod.dev) (`flutter_riverpod`) |
| Authentication | `firebase_auth`, `google_sign_in` |
| Database | `cloud_firestore` (offline persistence), `shared_preferences` (local fallback & language) |
| Localization | `flutter_localizations`, `intl`, ARB files with `flutter gen-l10n` |

## Project structure

```text
lib/
├── core/
│   ├── theme/            # AppTheme (light/dark) + NutrientColors theme extension
│   ├── utils/            # Localized labels for foods, tips, meal types…
│   └── widgets/          # LanguageSwitcherButton
├── data/
│   ├── models/           # AppUser
│   ├── repositories/     # AuthRepository, NutritionRepository (Firestore + local)
│   └── services/         # FirebaseBootstrap (safe init + offline persistence)
├── domain/
│   ├── calculator/       # CalorieMacroCalculator (Mifflin-St Jeor)
│   ├── foods/            # Common foods list (values per 100 g)
│   ├── models/           # UserProfile, MacroTargets, Meal, MealType, WeightLossTip…
│   └── tips/             # SmartTipsEngine
├── features/
│   ├── auth/             # Sign-in screen + AuthGate (routing by auth/profile state)
│   ├── onboarding/       # Health profile form with live targets preview
│   ├── dashboard/        # Calorie ring, macro bars, meals list
│   ├── add_meal/         # Add-meal bottom sheet
│   ├── tips/             # Smart tip card + all tips screen
│   └── shell/            # Bottom NavigationBar
├── l10n/                 # app_en.arb (template), app_ar.arb, app_tr.arb
├── providers/            # Riverpod providers (auth, nutrition, locale)
└── main.dart
```

**Data flow:** `Screens → Riverpod providers → Repositories → Firestore (or SharedPreferences)`.
Firestore layout: `users/{uid}` holds the profile and targets, `users/{uid}/meals/{mealId}` holds the meal log.

## Getting started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) **3.47 or newer** (stable channel)
- Android SDK (via Android Studio or command-line tools) and **JDK 17**
- An Android device or emulator

### Run it

```bash
git clone https://github.com/m07adee/calorie-tracker-flutter.git
cd calorie-tracker-flutter
flutter pub get
flutter run
```

> **No Firebase? No problem.** If `android/app/google-services.json` is missing, the app starts in **local mode**: you can continue as a guest and everything is saved on the device. Email and Google sign-in become available once you connect Firebase.

## Connecting your own Firebase project

1. Create a project in the [Firebase Console](https://console.firebase.google.com).
2. Add an **Android app** with the package name `com.health.calorie_tracker`.
3. Get the SHA-1 and SHA-256 fingerprints of your signing key and add them to the Android app settings (required for Google sign-in):
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
4. **Authentication → Sign-in method:** enable **Anonymous**, **Email/Password** and **Google**.
5. **Firestore Database:** create a database, then publish the security rules from [`firestore.rules`](firestore.rules) (users can only read and write their own data):
   ```bash
   firebase deploy --only firestore:rules --project <your-project-id>
   ```
6. Download `google-services.json` (after adding the fingerprints) and place it at `android/app/google-services.json`.

The Gradle `google-services` plugin is applied **automatically** when that file exists — no code changes needed.

> `google-services.json` is listed in `.gitignore` on purpose: every developer uses their own Firebase project.

## Building a release APK

```bash
flutter build apk --release
# smaller per-architecture APKs:
flutter build apk --release --split-per-abi
```

The output is in `build/app/outputs/flutter-apk/`.
The release build is currently signed with the **debug key** (see `android/app/build.gradle.kts`) so it can be shared directly. Before publishing to Google Play, [create your own upload key](https://docs.flutter.dev/deployment/android#sign-the-app) and add its fingerprints to Firebase.

## How to customize the app

| I want to change… | Edit this file |
|---|---|
| Calorie formula, deficit, macro percentages | `lib/domain/calculator/calorie_macro_calculator.dart` |
| Activity level multipliers | `lib/domain/models/activity_level.dart` |
| Common foods list and nutrition values | `lib/domain/foods/common_foods.dart` (+ names in the ARB files) |
| When smart tips appear | `lib/domain/tips/smart_tips_engine.dart` |
| App colors / nutrient colors | `lib/core/theme/app_theme.dart`, `lib/core/theme/nutrient_colors.dart` |
| Any text shown in the app | `lib/l10n/app_en.arb`, `app_ar.arb`, `app_tr.arb` |
| Database structure | `lib/data/repositories/nutrition_repository.dart` + `firestore.rules` |

## Localization

All UI text lives in ARB files — **never hardcode strings in Dart**.

1. Add the new key to **all three** files: `lib/l10n/app_en.arb` (template), `app_ar.arb`, `app_tr.arb`.
2. Regenerate the localization classes:
   ```bash
   flutter gen-l10n
   ```
3. Use it in a widget: `AppLocalizations.of(context).yourKey`.

To add a new language, create `app_<code>.arb` and add the language to `AppLanguage` in `lib/providers/locale_provider.dart`.

## Testing

```bash
flutter analyze
flutter test
```

The widget tests cover the full guest journey (sign-in → health profile → dashboard → add a meal) and the error screen shown when data can't be loaded. Every push and pull request runs both checks via [GitHub Actions](.github/workflows/ci.yml).

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## Disclaimer

This app provides general nutrition estimates for educational purposes and is **not medical advice**. Consult a healthcare professional before starting a diet.

## License

Released under the [MIT License](LICENSE).
