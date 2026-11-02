import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/widgets/language_switcher_button.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_providers.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _busy = false;
  bool _obscurePassword = true;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // بعد نجاح الدخول تنتقل البوابة تلقائياً للشاشة التالية عبر authStateProvider
  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = _errorMessage(error, AppLocalizations.of(context)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _submitEmail({required bool register}) {
    if (!_formKey.currentState!.validate()) return;
    final repository = ref.read(authRepositoryProvider);
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    _run(() => register
        ? repository.registerWithEmail(email, password)
        : repository.signInWithEmail(email, password));
  }

  String? _errorMessage(Object error, AppLocalizations l10n) {
    if (error is GoogleSignInException && error.code == GoogleSignInExceptionCode.canceled) {
      return null;
    }
    if (error is FirebaseAuthException) {
      return switch (error.code) {
        'invalid-credential' || 'wrong-password' || 'user-not-found' => l10n.authErrorCredentials,
        'email-already-in-use' || 'credential-already-in-use' => l10n.authErrorEmailInUse,
        'weak-password' => l10n.authErrorWeakPassword,
        'invalid-email' => l10n.authErrorInvalidEmail,
        _ => l10n.authErrorGeneric,
      };
    }
    return l10n.authErrorGeneric;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final repository = ref.watch(authRepositoryProvider);
    final accountsEnabled = repository.supportsAccountSignIn && !_busy;

    return Scaffold(
      appBar: AppBar(actions: const [LanguageSwitcherButton(), SizedBox(width: 12)]),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 84,
                      height: 84,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [scheme.primary, scheme.tertiary]),
                      ),
                      child: const Text('🥗', style: TextStyle(fontSize: 40)),
                    ),
                    const SizedBox(height: 20),
                    Text(l10n.authWelcome,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text(l10n.authSubtitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant)),
                    const SizedBox(height: 28),
                    if (!repository.supportsAccountSignIn) ...[
                      Card(
                        color: scheme.secondaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(l10n.authLocalMode,
                              style: TextStyle(color: scheme.onSecondaryContainer)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    TextFormField(
                      controller: _emailController,
                      enabled: accountsEnabled,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      decoration: InputDecoration(
                        labelText: l10n.authEmail,
                        prefixIcon: const Icon(Icons.mail_outline),
                      ),
                      validator: (value) =>
                          (value ?? '').trim().contains('@') ? null : l10n.authErrorInvalidEmail,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passwordController,
                      enabled: accountsEnabled,
                      obscureText: _obscurePassword,
                      autofillHints: const [AutofillHints.password],
                      decoration: InputDecoration(
                        labelText: l10n.authPassword,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      validator: (value) => (value ?? '').length >= 6 ? null : l10n.authErrorWeakPassword,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _error == null
                          ? const SizedBox(height: 16)
                          : Padding(
                              key: ValueKey(_error),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(_error!, style: TextStyle(color: scheme.error)),
                            ),
                    ),
                    FilledButton(
                      onPressed: accountsEnabled ? () => _submitEmail(register: false) : null,
                      child: _busy
                          ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2))
                          : Text(l10n.authSignIn),
                    ),
                    TextButton(
                      onPressed: accountsEnabled ? () => _submitEmail(register: true) : null,
                      child: Text(l10n.authCreateAccount),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(l10n.authOr, style: TextStyle(color: scheme.onSurfaceVariant)),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: accountsEnabled ? () => _run(repository.signInWithGoogle) : null,
                      icon: const Text('G', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      label: Text(l10n.authGoogle),
                    ),
                    const SizedBox(height: 12),
                    FilledButton.tonalIcon(
                      onPressed: _busy ? null : () => _run(repository.signInAnonymously),
                      icon: const Icon(Icons.person_outline),
                      label: Text(l10n.authGuest),
                      style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
