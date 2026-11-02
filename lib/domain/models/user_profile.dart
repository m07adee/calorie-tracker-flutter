import 'activity_level.dart';
import 'gender.dart';

class UserProfile {
  const UserProfile({
    required this.gender,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.targetWeightKg,
    required this.activityLevel,
  });

  final Gender gender;
  final int age;
  final double heightCm;
  final double weightKg;
  final double targetWeightKg;
  final ActivityLevel activityLevel;

  UserProfile copyWith({
    Gender? gender,
    int? age,
    double? heightCm,
    double? weightKg,
    double? targetWeightKg,
    ActivityLevel? activityLevel,
  }) {
    return UserProfile(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }

  Map<String, dynamic> toMap() => {
        'gender': gender.name,
        'age': age,
        'heightCm': heightCm,
        'weightKg': weightKg,
        'targetWeightKg': targetWeightKg,
        'activityLevel': activityLevel.name,
      };

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      gender: Gender.values.byName(map['gender'] as String),
      age: (map['age'] as num).toInt(),
      heightCm: (map['heightCm'] as num).toDouble(),
      weightKg: (map['weightKg'] as num).toDouble(),
      targetWeightKg: (map['targetWeightKg'] as num).toDouble(),
      activityLevel: ActivityLevel.values.byName(map['activityLevel'] as String),
    );
  }
}
