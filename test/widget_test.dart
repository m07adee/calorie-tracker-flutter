import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calorie_tracker/data/models/app_user.dart';
import 'package:calorie_tracker/main.dart';
import 'package:calorie_tracker/providers/auth_providers.dart';
import 'package:calorie_tracker/providers/core_providers.dart';
import 'package:calorie_tracker/providers/nutrition_providers.dart';

void main() {
  testWidgets('فشل قراءة الملف الصحي يعرض شاشة خطأ بدل التحميل اللانهائي', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          authStateProvider.overrideWith((ref) => Stream.value(const AppUser(uid: 'u1', isAnonymous: true))),
          userProfileProvider.overrideWith((ref) => Stream.error(Exception('PERMISSION_DENIED'))),
        ],
        child: const CalorieTrackerApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("Couldn't load your data"), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('رحلة الضيف بوضع التخزين المحلي: دخول ← ملف صحي ← الرئيسية ← إضافة وجبة',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const CalorieTrackerApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome'), findsOneWidget);
    await tester.tap(find.text('Continue as guest'));
    await tester.pumpAndSettle();

    expect(find.text("Let's start your health journey"), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Save and start'), 300);
    await tester.tap(find.text('Save and start'));
    await tester.pumpAndSettle();

    expect(find.text('Your day'), findsOneWidget);
    await tester.tap(find.widgetWithText(FloatingActionButton, 'Add meal'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Boiled eggs'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add to my day'));
    await tester.pumpAndSettle();

    // الوجبة تظهر في قائمة اليوم وتُضاف سعراتها للمستهلك فوراً
    await tester.scrollUntilVisible(find.text('Boiled eggs'), 300);
    expect(find.text('Boiled eggs'), findsOneWidget);
    expect(find.text('155 kcal'), findsWidgets);
  });
}
