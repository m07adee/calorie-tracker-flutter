// معرّفات الأطعمة الشائعة، وأسماؤها المترجمة في localized_text.dart
enum CommonFoodId {
  boiledEggs,
  grilledChicken,
  whiteRice,
  arabicBread,
  oats,
  yogurt,
  foul,
  hummus,
  salmon,
  salad,
  apple,
  banana,
  dates,
  almonds,
}

// القيم الغذائية لكل 100 غرام، مع حجم الحصة الافتراضية بالغرام
class CommonFood {
  const CommonFood({
    required this.id,
    required this.servingGrams,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatsPer100g,
  });

  final CommonFoodId id;
  final int servingGrams;
  final double caloriesPer100g;
  final double proteinPer100g;
  final double carbsPer100g;
  final double fatsPer100g;
}

const commonFoods = <CommonFood>[
  CommonFood(id: CommonFoodId.boiledEggs, servingGrams: 100, caloriesPer100g: 155, proteinPer100g: 13, carbsPer100g: 1.1, fatsPer100g: 11),
  CommonFood(id: CommonFoodId.grilledChicken, servingGrams: 150, caloriesPer100g: 165, proteinPer100g: 31, carbsPer100g: 0, fatsPer100g: 3.6),
  CommonFood(id: CommonFoodId.whiteRice, servingGrams: 150, caloriesPer100g: 130, proteinPer100g: 2.7, carbsPer100g: 28, fatsPer100g: 0.3),
  CommonFood(id: CommonFoodId.arabicBread, servingGrams: 60, caloriesPer100g: 275, proteinPer100g: 9, carbsPer100g: 55, fatsPer100g: 1.2),
  CommonFood(id: CommonFoodId.oats, servingGrams: 40, caloriesPer100g: 389, proteinPer100g: 17, carbsPer100g: 66, fatsPer100g: 7),
  CommonFood(id: CommonFoodId.yogurt, servingGrams: 170, caloriesPer100g: 61, proteinPer100g: 3.5, carbsPer100g: 4.7, fatsPer100g: 3.3),
  CommonFood(id: CommonFoodId.foul, servingGrams: 150, caloriesPer100g: 110, proteinPer100g: 7.6, carbsPer100g: 19.7, fatsPer100g: 0.4),
  CommonFood(id: CommonFoodId.hummus, servingGrams: 100, caloriesPer100g: 166, proteinPer100g: 8, carbsPer100g: 14, fatsPer100g: 9.6),
  CommonFood(id: CommonFoodId.salmon, servingGrams: 150, caloriesPer100g: 208, proteinPer100g: 20, carbsPer100g: 0, fatsPer100g: 13),
  CommonFood(id: CommonFoodId.salad, servingGrams: 150, caloriesPer100g: 20, proteinPer100g: 1, carbsPer100g: 4, fatsPer100g: 0.2),
  CommonFood(id: CommonFoodId.apple, servingGrams: 180, caloriesPer100g: 52, proteinPer100g: 0.3, carbsPer100g: 14, fatsPer100g: 0.2),
  CommonFood(id: CommonFoodId.banana, servingGrams: 120, caloriesPer100g: 89, proteinPer100g: 1.1, carbsPer100g: 23, fatsPer100g: 0.3),
  CommonFood(id: CommonFoodId.dates, servingGrams: 30, caloriesPer100g: 282, proteinPer100g: 2.5, carbsPer100g: 75, fatsPer100g: 0.4),
  CommonFood(id: CommonFoodId.almonds, servingGrams: 30, caloriesPer100g: 579, proteinPer100g: 21, carbsPer100g: 22, fatsPer100g: 50),
];
