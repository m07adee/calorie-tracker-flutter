import 'meal_type.dart';

class Meal {
  const Meal({
    this.id = '',
    required this.name,
    required this.mealType,
    required this.quantityGrams,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.dayKey,
    required this.createdAtMillis,
  });

  /// فارغ للوجبة الجديدة، ويُعيّنه المستودع عند الحفظ
  final String id;
  final String name;
  final MealType mealType;
  final double quantityGrams;
  final int calories;
  final double protein;
  final double carbs;
  final double fats;

  /// اليوم بصيغة yyyy-MM-dd لتجميع وجبات اليوم الواحد
  final String dayKey;
  final int createdAtMillis;

  static String dayKeyFor(DateTime date) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${date.year}-${two(date.month)}-${two(date.day)}';
  }

  Meal copyWith({String? id}) {
    return Meal(
      id: id ?? this.id,
      name: name,
      mealType: mealType,
      quantityGrams: quantityGrams,
      calories: calories,
      protein: protein,
      carbs: carbs,
      fats: fats,
      dayKey: dayKey,
      createdAtMillis: createdAtMillis,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'mealType': mealType.name,
        'quantityGrams': quantityGrams,
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fats': fats,
        'dayKey': dayKey,
        'createdAtMillis': createdAtMillis,
      };

  factory Meal.fromMap(String id, Map<String, dynamic> map) {
    return Meal(
      id: id,
      name: map['name'] as String,
      mealType: MealType.values.byName(map['mealType'] as String),
      quantityGrams: (map['quantityGrams'] as num).toDouble(),
      calories: (map['calories'] as num).toInt(),
      protein: (map['protein'] as num).toDouble(),
      carbs: (map['carbs'] as num).toDouble(),
      fats: (map['fats'] as num).toDouble(),
      dayKey: map['dayKey'] as String,
      createdAtMillis: (map['createdAtMillis'] as num).toInt(),
    );
  }
}

// مجموع ما استهلكه المستخدم في يوم واحد
class DailyTotals {
  const DailyTotals({this.calories = 0, this.protein = 0, this.carbs = 0, this.fats = 0});

  final int calories;
  final double protein;
  final double carbs;
  final double fats;

  factory DailyTotals.fromMeals(Iterable<Meal> meals) {
    var calories = 0;
    var protein = 0.0, carbs = 0.0, fats = 0.0;
    for (final meal in meals) {
      calories += meal.calories;
      protein += meal.protein;
      carbs += meal.carbs;
      fats += meal.fats;
    }
    return DailyTotals(calories: calories, protein: protein, carbs: carbs, fats: fats);
  }
}
