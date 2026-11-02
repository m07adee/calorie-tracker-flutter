import 'package:flutter/material.dart';

import '../../../core/theme/nutrient_colors.dart';
import '../../../l10n/app_localizations.dart';

// شريط تقدم متحرك لمغذٍ واحد بالجرام، يمتلئ من بداية السطر حسب اتجاه اللغة
class MacroProgressBar extends StatelessWidget {
  const MacroProgressBar({
    super.key,
    required this.label,
    required this.consumedGrams,
    required this.targetGrams,
    required this.color,
  });

  final String label;
  final double consumedGrams;
  final int targetGrams;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final progress = targetGrams > 0 ? (consumedGrams / targetGrams).clamp(0.0, 1.0) : 0.0;
    final remaining = (targetGrams - consumedGrams).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600))),
            Text(
              l10n.macroProgressValue(consumedGrams.round(), targetGrams),
              style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 10,
            child: Stack(
              children: [
                Positioned.fill(child: ColoredBox(color: theme.nutrients.track)),
                TweenAnimationBuilder<double>(
                  tween: Tween(end: progress),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, _) => FractionallySizedBox(
                    alignment: AlignmentDirectional.centerStart,
                    widthFactor: value,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          remaining >= 0 ? l10n.macroRemaining(remaining) : l10n.macroOver(-remaining),
          style: theme.textTheme.labelSmall?.copyWith(
            color: remaining >= 0 ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.error,
          ),
        ),
      ],
    );
  }
}
