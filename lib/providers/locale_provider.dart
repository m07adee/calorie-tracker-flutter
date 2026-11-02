import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core_providers.dart';

// أسماء اللغات تُعرض دائماً بلغتها الأصلية لذلك لا توضع في ملفات الترجمة
enum AppLanguage {
  arabic('ar', 'العربية', '🇸🇦'),
  turkish('tr', 'Türkçe', '🇹🇷'),
  english('en', 'English', '🇺🇸');

  const AppLanguage(this.code, this.nativeName, this.flag);

  final String code;
  final String nativeName;
  final String flag;

  Locale get locale => Locale(code);

  static AppLanguage? fromCode(String? code) {
    for (final language in values) {
      if (language.code == code) return language;
    }
    return null;
  }
}

/// اللغة المختارة داخل التطبيق، أو null لاتباع لغة الجهاز.
/// تغييرها يعيد بناء MaterialApp فوراً فيتبدل النص والاتجاه دون إعادة التشغيل.
class LocaleNotifier extends Notifier<Locale?> {
  static const _key = 'app_locale';

  @override
  Locale? build() {
    return AppLanguage.fromCode(ref.read(sharedPreferencesProvider).getString(_key))?.locale;
  }

  Future<void> setLanguage(AppLanguage language) async {
    state = language.locale;
    await ref.read(sharedPreferencesProvider).setString(_key, language.code);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(LocaleNotifier.new);
