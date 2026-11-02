import 'package:flutter/material.dart';

import '../../../core/theme/nutrient_colors.dart';
import '../../../core/utils/localized_text.dart';
import '../../../domain/models/weight_loss_tip.dart';
import '../../../l10n/app_localizations.dart';

extension TipStyle on WeightLossTip {
  Color accent(ThemeData theme) => switch (tone) {
        TipTone.warning => theme.nutrients.fats,
        TipTone.positive => theme.nutrients.calories,
        TipTone.info => theme.nutrients.protein,
      };

  String get emoji => switch (this) {
        WeightLossTip.completeProfile => '📝',
        WeightLossTip.startWithProteinBreakfast => '🍳',
        WeightLossTip.noMealsYet => '⏰',
        WeightLossTip.overCalories => '⚠️',
        WeightLossTip.lowProtein => '🥚',
        WeightLossTip.highFats => '🥑',
        WeightLossTip.highCarbs => '🍞',
        WeightLossTip.underEating => '🍽️',
        WeightLossTip.closeToTarget => '🎯',
        WeightLossTip.onTrack => '🌟',
        WeightLossTip.drinkWater => '💧',
        WeightLossTip.dailyWalking => '🚶',
        WeightLossTip.strengthTraining => '🏋️',
        WeightLossTip.sleepWell => '😴',
        WeightLossTip.eatFiber => '🥦',
        WeightLossTip.proteinEveryMeal => '🍗',
        WeightLossTip.avoidSugaryDrinks => '🥤',
        WeightLossTip.eatSlowly => '🐢',
        WeightLossTip.waterBeforeMeals => '🥛',
        WeightLossTip.moveMoreDaily => '🔥',
      };
}

/// بطاقة النصيحة الذكية: تتبدل بحركة ناعمة كلما تغيّر استهلاك اليوم
class SmartTipCard extends StatelessWidget {
  const SmartTipCard({super.key, required this.tip, this.onViewAll});

  final WeightLossTip tip;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final accent = tip.accent(theme);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      padding: const EdgeInsets.all(18),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        child: Column(
          key: ValueKey(tip),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TipBadge(tip: tip, size: 42),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(l10n.tipsSmartLabel,
                      style: theme.textTheme.labelLarge?.copyWith(color: accent, fontWeight: FontWeight.w700)),
                ),
                if (onViewAll != null) TextButton(onPressed: onViewAll, child: Text(l10n.tipsViewAll)),
              ],
            ),
            const SizedBox(height: 10),
            Text(tip.title(l10n), style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(tip.body(l10n),
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

class TipCard extends StatelessWidget {
  const TipCard({super.key, required this.tip});

  final WeightLossTip tip;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TipBadge(tip: tip, size: 38),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tip.title(l10n), style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(tip.body(l10n),
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TipBadge extends StatelessWidget {
  const TipBadge({super.key, required this.tip, required this.size});

  final WeightLossTip tip;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: tip.accent(Theme.of(context)).withValues(alpha: 0.2),
      ),
      child: Text(tip.emoji, style: TextStyle(fontSize: size / 2)),
    );
  }
}
