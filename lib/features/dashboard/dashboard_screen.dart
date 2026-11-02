import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/nutrient_colors.dart';
import '../../core/utils/localized_text.dart';
import '../../domain/models/macro_targets.dart';
import '../../domain/models/meal.dart';
import '../../domain/models/meal_type.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/nutrition_providers.dart';
import '../tips/widgets/tip_cards.dart';
import 'widgets/calorie_ring.dart';
import 'widgets/macro_progress_bar.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key, this.onOpenTips});

  final VoidCallback? onOpenTips;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final targets = ref.watch(macroTargetsProvider).value;
    final totals = ref.watch(todayTotalsProvider);
    final meals = ref.watch(todayMealsProvider).value ?? const <Meal>[];
    final tips = ref.watch(smartTipsProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
      children: [
        Text(l10n.dashboardTitle, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        if (targets != null)
          _DailySummaryCard(targets: targets, totals: totals)
        else
          Card(
            color: theme.colorScheme.secondaryContainer,
            child: Padding(padding: const EdgeInsets.all(20), child: Text(l10n.dashboardMissingProfile)),
          ),
        const SizedBox(height: 16),
        SmartTipCard(tip: tips.primary, onViewAll: onOpenTips),
        const SizedBox(height: 8),
        for (final type in MealType.values)
          _MealSection(type: type, meals: meals.where((meal) => meal.mealType == type).toList()),
        if (meals.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(l10n.dashboardSwipeHint,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ),
      ],
    );
  }
}

class _DailySummaryCard extends StatelessWidget {
  const _DailySummaryCard({required this.targets, required this.totals});

  final MacroTargets targets;
  final DailyTotals totals;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final nutrients = Theme.of(context).nutrients;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CalorieRing(targetCalories: targets.targetCalories, consumedCalories: totals.calories),
            const SizedBox(height: 20),
            MacroProgressBar(
              label: l10n.macroProtein,
              consumedGrams: totals.protein,
              targetGrams: targets.proteinGrams,
              color: nutrients.protein,
            ),
            const SizedBox(height: 14),
            MacroProgressBar(
              label: l10n.macroCarbs,
              consumedGrams: totals.carbs,
              targetGrams: targets.carbsGrams,
              color: nutrients.carbs,
            ),
            const SizedBox(height: 14),
            MacroProgressBar(
              label: l10n.macroFats,
              consumedGrams: totals.fats,
              targetGrams: targets.fatsGrams,
              color: nutrients.fats,
            ),
          ],
        ),
      ),
    );
  }
}

class _MealSection extends ConsumerWidget {
  const _MealSection({required this.type, required this.meals});

  final MealType type;
  final List<Meal> meals;

  // الحذف بالسحب مع إمكانية التراجع وإعادة الوجبة بنفس معرّفها
  void _delete(BuildContext context, WidgetRef ref, Meal meal) {
    final repository = ref.read(nutritionRepositoryProvider);
    if (repository == null) return;
    repository.deleteMeal(meal.id);
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(l10n.dashboardMealDeleted),
        action: SnackBarAction(label: l10n.actionUndo, onPressed: () => repository.addMeal(meal)),
      ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final total = meals.fold<int>(0, (sum, meal) => sum + meal.calories);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(type.label(l10n),
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              ),
              Text(l10n.unitKcalValue(total),
                  style: theme.textTheme.labelLarge?.copyWith(color: theme.nutrients.calories)),
            ],
          ),
        ),
        if (meals.isEmpty)
          Text(l10n.dashboardNoMeals,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        for (final meal in meals)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Dismissible(
              key: ValueKey(meal.id),
              onDismissed: (_) => _delete(context, ref, meal),
              background: const _DeleteBackground(alignment: AlignmentDirectional.centerStart),
              secondaryBackground: const _DeleteBackground(alignment: AlignmentDirectional.centerEnd),
              child: _MealTile(meal: meal),
            ),
          ),
      ],
    );
  }
}

class _MealTile extends StatelessWidget {
  const _MealTile({required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceContainer,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(meal.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(l10n.dashboardMealDetails(
          meal.quantityGrams.round(),
          meal.protein.round(),
          meal.carbs.round(),
          meal.fats.round(),
        )),
        trailing: Text(
          l10n.unitKcalValue(meal.calories),
          style: theme.textTheme.titleSmall?.copyWith(color: theme.nutrients.calories, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground({required this.alignment});

  final AlignmentDirectional alignment;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(color: scheme.errorContainer, borderRadius: BorderRadius.circular(24)),
      child: Icon(Icons.delete_outline, color: scheme.onErrorContainer),
    );
  }
}
