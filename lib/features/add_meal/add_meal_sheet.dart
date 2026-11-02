import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/nutrient_colors.dart';
import '../../core/utils/localized_text.dart';
import '../../domain/foods/common_foods.dart';
import '../../domain/models/meal.dart';
import '../../domain/models/meal_type.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/nutrition_providers.dart';

Future<void> showAddMealSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const AddMealSheet(),
  );
}

class AddMealSheet extends ConsumerStatefulWidget {
  const AddMealSheet({super.key});

  @override
  ConsumerState<AddMealSheet> createState() => _AddMealSheetState();
}

class _AddMealSheetState extends ConsumerState<AddMealSheet> {
  final _name = TextEditingController();
  final _quantity = TextEditingController();
  final _calories = TextEditingController();
  final _protein = TextEditingController();
  final _carbs = TextEditingController();
  final _fats = TextEditingController();
  late MealType _mealType = _defaultMealTypeForNow();

  // الطعام الشائع المختار، ويُلغى عند تعديل القيم يدوياً
  CommonFood? _selectedFood;

  @override
  void dispose() {
    for (final controller in [_name, _quantity, _calories, _protein, _carbs, _fats]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _selectFood(CommonFood food, AppLocalizations l10n) {
    setState(() {
      _selectedFood = food;
      _name.text = food.name(l10n);
      _quantity.text = food.servingGrams.toString();
      _applyFood(food, food.servingGrams.toDouble());
    });
  }

  void _applyFood(CommonFood food, double grams) {
    final factor = grams / 100;
    _calories.text = (food.caloriesPer100g * factor).round().toString();
    _protein.text = _format(food.proteinPer100g * factor);
    _carbs.text = _format(food.carbsPer100g * factor);
    _fats.text = _format(food.fatsPer100g * factor);
  }

  // إعادة حساب القيم تلقائياً حسب الكمية للطعام المختار
  void _onQuantityChanged(String value) {
    final grams = double.tryParse(value);
    final food = _selectedFood;
    setState(() {
      if (food != null && grams != null) _applyFood(food, grams);
    });
  }

  void _onManualEdit(String _) => setState(() => _selectedFood = null);

  int? get _caloriesValue => double.tryParse(_calories.text)?.round();

  bool get _isValid => _name.text.trim().isNotEmpty && (_caloriesValue ?? 0) > 0;

  Future<void> _submit() async {
    final repository = ref.read(nutritionRepositoryProvider);
    if (repository == null || !_isValid) return;
    final now = DateTime.now();
    await repository.addMeal(Meal(
      name: _name.text.trim(),
      mealType: _mealType,
      quantityGrams: double.tryParse(_quantity.text) ?? 0,
      calories: _caloriesValue!,
      protein: double.tryParse(_protein.text) ?? 0,
      carbs: double.tryParse(_carbs.text) ?? 0,
      fats: double.tryParse(_fats.text) ?? 0,
      dayKey: Meal.dayKeyFor(now),
      createdAtMillis: now.millisecondsSinceEpoch,
    ));
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final targets = ref.watch(macroTargetsProvider).value;
    final consumed = ref.watch(todayTotalsProvider).calories;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.addMealTitle, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            Text(l10n.addMealCommonFoods, style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: commonFoods.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final food = commonFoods[index];
                  return ChoiceChip(
                    label: Text(food.name(l10n)),
                    selected: identical(food, _selectedFood),
                    onSelected: (_) => _selectFood(food, l10n),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: l10n.addMealName),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            Text(l10n.addMealType, style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final type in MealType.values)
                  ChoiceChip(
                    label: Text(type.label(l10n)),
                    selected: type == _mealType,
                    onSelected: (_) => setState(() => _mealType = type),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _NumberField(
                    controller: _quantity,
                    label: l10n.addMealQuantity,
                    suffix: l10n.unitGShort,
                    onChanged: _onQuantityChanged,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NumberField(
                    controller: _calories,
                    label: l10n.addMealCalories,
                    suffix: l10n.unitKcal,
                    onChanged: _onManualEdit,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _NumberField(
                      controller: _protein, label: l10n.macroProtein, suffix: l10n.unitGShort, onChanged: _onManualEdit),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _NumberField(
                      controller: _carbs, label: l10n.macroCarbs, suffix: l10n.unitGShort, onChanged: _onManualEdit),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _NumberField(
                      controller: _fats, label: l10n.macroFats, suffix: l10n.unitGShort, onChanged: _onManualEdit),
                ),
              ],
            ),
            if (targets != null) ...[
              const SizedBox(height: 16),
              _RemainingPreview(remainingAfter: targets.targetCalories - consumed - (_caloriesValue ?? 0)),
            ],
            const SizedBox(height: 20),
            FilledButton(onPressed: _isValid ? _submit : null, child: Text(l10n.addMealSubmit)),
          ],
        ),
      ),
    );
  }
}

// معاينة فورية لما سيتبقى من سعرات اليوم بعد إضافة الوجبة
class _RemainingPreview extends StatelessWidget {
  const _RemainingPreview({required this.remainingAfter});

  final int remainingAfter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isOver = remainingAfter < 0;
    final color = isOver ? theme.colorScheme.error : theme.nutrients.calories;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        isOver ? l10n.addMealPreviewOver(-remainingAfter) : l10n.addMealPreviewRemaining(remainingAfter),
        style: theme.textTheme.titleSmall?.copyWith(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.controller,
    required this.label,
    required this.suffix,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final String suffix;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.next,
      inputFormatters: [_DecimalFormatter()],
      decoration: InputDecoration(labelText: label, suffixText: suffix),
      onChanged: onChanged,
    );
  }
}

/// يحوّل الأرقام العربية الهندية إلى لاتينية ويُبقي رقماً عشرياً صالحاً فقط
class _DecimalFormatter extends TextInputFormatter {
  static const _arabicDigits = '٠١٢٣٤٥٦٧٨٩';

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final buffer = StringBuffer();
    var hasDot = false;
    for (final char in newValue.text.split('')) {
      final arabicIndex = _arabicDigits.indexOf(char);
      if (arabicIndex >= 0) {
        buffer.write(arabicIndex);
      } else if (RegExp(r'\d').hasMatch(char)) {
        buffer.write(char);
      } else if ((char == '.' || char == ',' || char == '٫') && !hasDot) {
        buffer.write('.');
        hasDot = true;
      }
    }
    final text = buffer.toString();
    return TextEditingValue(text: text, selection: TextSelection.collapsed(offset: text.length));
  }
}

String _format(double value) {
  final rounded = (value * 10).round() / 10;
  return rounded == rounded.roundToDouble() ? rounded.round().toString() : rounded.toString();
}

MealType _defaultMealTypeForNow() {
  final hour = DateTime.now().hour;
  if (hour >= 4 && hour <= 10) return MealType.breakfast;
  if (hour >= 11 && hour <= 15) return MealType.lunch;
  if (hour >= 18 && hour <= 22) return MealType.dinner;
  return MealType.snack;
}
