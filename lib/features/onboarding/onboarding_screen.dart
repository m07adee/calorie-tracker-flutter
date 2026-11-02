import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/nutrient_colors.dart';
import '../../core/utils/localized_text.dart';
import '../../core/widgets/language_switcher_button.dart';
import '../../domain/calculator/calorie_macro_calculator.dart';
import '../../domain/models/activity_level.dart';
import '../../domain/models/gender.dart';
import '../../domain/models/macro_targets.dart';
import '../../domain/models/user_profile.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_providers.dart';
import '../../providers/nutrition_providers.dart';

/// إدخال الملف الصحي: شاشة كاملة عند أول استخدام، أو محتوى تبويب "ملفي" عند [embedded]
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key, this.embedded = false});

  final bool embedded;

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late UserProfile _profile;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _profile = ref.read(userProfileProvider).value ??
        const UserProfile(
          gender: Gender.male,
          age: 30,
          heightCm: 170,
          weightKg: 80,
          targetWeightKg: 70,
          activityLevel: ActivityLevel.moderate,
        );
  }

  void _update(UserProfile profile) => setState(() => _profile = profile);

  Future<void> _save() async {
    final repository = ref.read(nutritionRepositoryProvider);
    if (repository == null) return;
    setState(() => _saving = true);
    await repository.saveProfile(_profile, CalorieMacroCalculator.calculate(_profile));
    if (!mounted) return;
    setState(() => _saving = false);
    // عند أول استخدام تنتقل البوابة تلقائياً للرئيسية بعد ظهور الملف المحفوظ
    if (widget.embedded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).profileSaved)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final targets = CalorieMacroCalculator.calculate(_profile);

    final content = ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        if (!widget.embedded) ...[
          Text(l10n.onboardingTitle,
              style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(l10n.onboardingSubtitle,
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 20),
        ],
        _TargetsPreviewCard(targets: targets),
        const SizedBox(height: 20),
        _SectionCard(
          title: l10n.onboardingSectionGender,
          child: _GenderSelector(
            selected: _profile.gender,
            onChanged: (gender) => _update(_profile.copyWith(gender: gender)),
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: l10n.onboardingSectionBody,
          child: Column(
            children: [
              _MeasurementSlider(
                label: l10n.labelAge,
                unit: l10n.unitYears,
                value: _profile.age.toDouble(),
                min: 15,
                max: 80,
                onChanged: (v) => _update(_profile.copyWith(age: v.round())),
              ),
              _MeasurementSlider(
                label: l10n.labelHeight,
                unit: l10n.unitCm,
                value: _profile.heightCm,
                min: 140,
                max: 210,
                onChanged: (v) => _update(_profile.copyWith(heightCm: v.roundToDouble())),
              ),
              _MeasurementSlider(
                label: l10n.labelWeight,
                unit: l10n.unitKg,
                value: _profile.weightKg,
                min: 40,
                max: 200,
                onChanged: (v) => _update(_profile.copyWith(weightKg: v.roundToDouble())),
              ),
              _MeasurementSlider(
                label: l10n.labelTargetWeight,
                unit: l10n.unitKg,
                value: _profile.targetWeightKg,
                min: 40,
                max: 200,
                onChanged: (v) => _update(_profile.copyWith(targetWeightKg: v.roundToDouble())),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: l10n.onboardingSectionActivity,
          child: _ActivitySelector(
            selected: _profile.activityLevel,
            onChanged: (level) => _update(_profile.copyWith(activityLevel: level)),
          ),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(l10n.actionSaveStart),
        ),
        if (widget.embedded) ...[
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => ref.read(authRepositoryProvider).signOut(),
            icon: const Icon(Icons.logout),
            label: Text(l10n.actionSignOut),
          ),
        ],
      ],
    );

    if (widget.embedded) return content;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        actions: const [LanguageSwitcherButton(), SizedBox(width: 12)],
      ),
      body: SafeArea(top: false, child: content),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

class _GenderSelector extends StatelessWidget {
  const _GenderSelector({required this.selected, required this.onChanged});

  final Gender selected;
  final ValueChanged<Gender> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        for (final gender in Gender.values) ...[
          if (gender != Gender.values.first) const SizedBox(width: 12),
          Expanded(
            child: _SelectableTile(
              selected: gender == selected,
              onTap: () => onChanged(gender),
              child: Column(
                children: [
                  Text(gender == Gender.male ? '👨' : '👩', style: const TextStyle(fontSize: 28)),
                  const SizedBox(height: 4),
                  Text(
                    gender.label(l10n),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: gender == selected ? scheme.onPrimaryContainer : scheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ActivitySelector extends StatelessWidget {
  const _ActivitySelector({required this.selected, required this.onChanged});

  final ActivityLevel selected;
  final ValueChanged<ActivityLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Column(
      children: [
        for (final level in ActivityLevel.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _SelectableTile(
              selected: level == selected,
              onTap: () => onChanged(level),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(level.label(l10n), style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text(level.description(l10n),
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  Text('×${level.multiplier}', style: theme.textTheme.labelLarge),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _SelectableTile extends StatelessWidget {
  const _SelectableTile({required this.selected, required this.onTap, required this.child});

  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: selected ? scheme.primaryContainer : scheme.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? scheme.primary : scheme.outlineVariant,
              width: selected ? 2 : 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _MeasurementSlider extends StatelessWidget {
  const _MeasurementSlider({
    required this.label,
    required this.unit,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final String unit;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Text(label, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ),
            Text(value.round().toString(),
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(width: 4),
            Text(unit, style: theme.textTheme.labelMedium),
          ],
        ),
        Slider(value: value.clamp(min, max), min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}

// بطاقة المعاينة الحية: تتحدث فوراً مع كل تغيير قبل الحفظ
class _TargetsPreviewCard extends StatelessWidget {
  const _TargetsPreviewCard({required this.targets});

  final MacroTargets targets;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final nutrients = theme.nutrients;
    final total = (targets.proteinCalories + targets.carbsCalories + targets.fatsCalories).clamp(1, 1 << 30);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [theme.colorScheme.primaryContainer, theme.colorScheme.tertiaryContainer],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.resultDailyCalories, style: theme.textTheme.titleMedium),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(end: targets.targetCalories.toDouble()),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) => Text(
                  value.round().toString(),
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: nutrients.calories,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(l10n.unitKcal, style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 4),
          Text('${l10n.resultBmr(targets.bmr)}   •   ${l10n.resultTdee(targets.tdee)}',
              style: theme.textTheme.labelMedium),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 12,
              child: Row(
                children: [
                  Expanded(flex: targets.proteinCalories * 1000 ~/ total, child: ColoredBox(color: nutrients.protein)),
                  const SizedBox(width: 3),
                  Expanded(flex: targets.carbsCalories * 1000 ~/ total, child: ColoredBox(color: nutrients.carbs)),
                  const SizedBox(width: 3),
                  Expanded(flex: targets.fatsCalories * 1000 ~/ total, child: ColoredBox(color: nutrients.fats)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _MacroLine(color: nutrients.protein, name: l10n.macroProtein, grams: targets.proteinGrams, kcal: targets.proteinCalories),
          _MacroLine(color: nutrients.carbs, name: l10n.macroCarbs, grams: targets.carbsGrams, kcal: targets.carbsCalories),
          _MacroLine(color: nutrients.fats, name: l10n.macroFats, grams: targets.fatsGrams, kcal: targets.fatsCalories),
        ],
      ),
    );
  }
}

class _MacroLine extends StatelessWidget {
  const _MacroLine({required this.color, required this.name, required this.grams, required this.kcal});

  final Color color;
  final String name;
  final int grams;
  final int kcal;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Expanded(child: Text(name, style: theme.textTheme.bodyLarge)),
          Text(l10n.unitGrams(grams), style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(width: 12),
          Text(l10n.unitKcalValue(kcal), style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}
