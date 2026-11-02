import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/nutrition_providers.dart';
import 'widgets/tip_cards.dart';

class TipsScreen extends ConsumerWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final tips = ref.watch(smartTipsProvider);

    Widget sectionTitle(String text) => Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 8),
          child: Text(text, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        );

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        Text(l10n.tipsTitle, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text(l10n.tipsSubtitle,
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: 16),
        SmartTipCard(tip: tips.primary),
        if (tips.contextual.isNotEmpty) ...[
          sectionTitle(l10n.tipsSectionToday),
          for (final tip in tips.contextual)
            Padding(padding: const EdgeInsets.only(bottom: 10), child: TipCard(tip: tip)),
        ],
        sectionTitle(l10n.tipsSectionGeneral),
        for (final tip in tips.general)
          Padding(padding: const EdgeInsets.only(bottom: 10), child: TipCard(tip: tip)),
      ],
    );
  }
}
