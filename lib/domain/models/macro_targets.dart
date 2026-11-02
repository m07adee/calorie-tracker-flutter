// الأهداف اليومية الناتجة عن الحاسبة: السعرات وتوزيع المغذيات بالجرام والسعرات
class MacroTargets {
  const MacroTargets({
    required this.bmr,
    required this.tdee,
    required this.targetCalories,
    required this.proteinGrams,
    required this.proteinCalories,
    required this.carbsGrams,
    required this.carbsCalories,
    required this.fatsGrams,
    required this.fatsCalories,
  });

  final int bmr;
  final int tdee;
  final int targetCalories;
  final int proteinGrams;
  final int proteinCalories;
  final int carbsGrams;
  final int carbsCalories;
  final int fatsGrams;
  final int fatsCalories;

  Map<String, dynamic> toMap() => {
        'bmr': bmr,
        'tdee': tdee,
        'targetCalories': targetCalories,
        'proteinGrams': proteinGrams,
        'proteinCalories': proteinCalories,
        'carbsGrams': carbsGrams,
        'carbsCalories': carbsCalories,
        'fatsGrams': fatsGrams,
        'fatsCalories': fatsCalories,
      };

  factory MacroTargets.fromMap(Map<String, dynamic> map) {
    int read(String key) => (map[key] as num).toInt();
    return MacroTargets(
      bmr: read('bmr'),
      tdee: read('tdee'),
      targetCalories: read('targetCalories'),
      proteinGrams: read('proteinGrams'),
      proteinCalories: read('proteinCalories'),
      carbsGrams: read('carbsGrams'),
      carbsCalories: read('carbsCalories'),
      fatsGrams: read('fatsGrams'),
      fatsCalories: read('fatsCalories'),
    );
  }
}
