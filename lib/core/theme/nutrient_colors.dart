import 'package:flutter/material.dart';

// ألوان المغذيات المستخدمة في الحلقة والأشرطة، متاحة عبر Theme.of(context).nutrients
@immutable
class NutrientColors extends ThemeExtension<NutrientColors> {
  const NutrientColors({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.track,
  });

  final Color calories;
  final Color protein;
  final Color carbs;
  final Color fats;
  final Color track;

  static const light = NutrientColors(
    calories: Color(0xFF0E9F6E),
    protein: Color(0xFF2F6FED),
    carbs: Color(0xFF8B5CF6),
    fats: Color(0xFFF59E0B),
    track: Color(0xFFE3EAE6),
  );

  static const dark = NutrientColors(
    calories: Color(0xFF34D399),
    protein: Color(0xFF7AA7FF),
    carbs: Color(0xFFB79CFF),
    fats: Color(0xFFFBBF24),
    track: Color(0xFF2A322E),
  );

  @override
  NutrientColors copyWith({Color? calories, Color? protein, Color? carbs, Color? fats, Color? track}) {
    return NutrientColors(
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      track: track ?? this.track,
    );
  }

  @override
  NutrientColors lerp(NutrientColors? other, double t) {
    if (other == null) return this;
    return NutrientColors(
      calories: Color.lerp(calories, other.calories, t)!,
      protein: Color.lerp(protein, other.protein, t)!,
      carbs: Color.lerp(carbs, other.carbs, t)!,
      fats: Color.lerp(fats, other.fats, t)!,
      track: Color.lerp(track, other.track, t)!,
    );
  }
}

extension NutrientColorsTheme on ThemeData {
  NutrientColors get nutrients => extension<NutrientColors>() ?? NutrientColors.light;
}
