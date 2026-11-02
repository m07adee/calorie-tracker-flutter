import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'data/services/firebase_bootstrap.dart';
import 'features/auth/auth_gate.dart';
import 'l10n/app_localizations.dart';
import 'providers/core_providers.dart';
import 'providers/locale_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // لا ينهار التطبيق عند غياب google-services.json، بل يعمل بوضع التخزين المحلي
  final firebaseEnabled = await FirebaseBootstrap.initialize();

  runApp(
    ProviderScope(
      // إيقاف إعادة المحاولة التلقائية في Riverpod 3 حتى تظهر الأخطاء فوراً بدل تحميل طويل
      retry: (_, _) => null,
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        firebaseEnabledProvider.overrideWithValue(firebaseEnabled),
      ],
      child: const CalorieTrackerApp(),
    ),
  );
}

class CalorieTrackerApp extends ConsumerWidget {
  const CalorieTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // الاتجاه (RTL للعربية وLTR للتركية والإنجليزية) يتبع اللغة تلقائياً
      locale: ref.watch(localeProvider),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const AuthGate(),
    );
  }
}
