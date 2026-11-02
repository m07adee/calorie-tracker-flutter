import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/auth_providers.dart';
import '../../providers/nutrition_providers.dart';
import '../onboarding/onboarding_screen.dart';
import '../shell/main_shell.dart';
import 'sign_in_screen.dart';

/// يوجّه المستخدم حسب حالته: تسجيل الدخول ← إدخال الملف الصحي ← الواجهة الرئيسية
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider);
    if (auth.isLoading && !auth.hasValue) return const _Splash();
    if (auth.value == null) return const SignInScreen();

    final profile = ref.watch(userProfileProvider);
    // فشل القراءة (مثل رفض قواعد Firestore) يُعرض للمستخدم بدل التحميل اللانهائي
    if (profile.hasError && !profile.hasValue) {
      debugPrint('Profile load failed: ${profile.error}');
      return const _LoadError();
    }
    if (profile.isLoading && !profile.hasValue) return const _Splash();
    if (profile.value == null) return const OnboardingScreen();
    return const MainShell();
  }
}

class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _LoadError extends ConsumerWidget {
  const _LoadError();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.cloud_off_outlined, size: 64, color: theme.colorScheme.error),
                const SizedBox(height: 16),
                Text(l10n.loadErrorTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(l10n.loadErrorBody,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => ref.invalidate(userProfileProvider),
                  icon: const Icon(Icons.refresh),
                  label: Text(l10n.actionRetry),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => ref.read(authRepositoryProvider).signOut(),
                  child: Text(l10n.actionSignOut),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
