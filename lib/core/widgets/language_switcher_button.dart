import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';

/// أعلام اللغات الثلاث في الشريط العلوي: ضغطة واحدة تبدّل اللغة والاتجاه فوراً
class LanguageSwitcherButton extends ConsumerWidget {
  const LanguageSwitcherButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = AppLanguage.fromCode(Localizations.localeOf(context).languageCode) ?? AppLanguage.english;
    final scheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: AppLocalizations.of(context).languageMenuLabel,
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final language in AppLanguage.values)
              _FlagChip(
                language: language,
                selected: language == current,
                onTap: () => ref.read(localeProvider.notifier).setLanguage(language),
              ),
          ],
        ),
      ),
    );
  }
}

class _FlagChip extends StatelessWidget {
  const _FlagChip({required this.language, required this.selected, required this.onTap});

  final AppLanguage language;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      selected: selected,
      label: language.nativeName,
      child: GestureDetector(
        onTap: selected ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? scheme.primaryContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: AnimatedScale(
            scale: selected ? 1.15 : 0.9,
            duration: const Duration(milliseconds: 250),
            child: Opacity(
              opacity: selected ? 1 : 0.6,
              child: Text(language.flag, style: const TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ),
    );
  }
}
