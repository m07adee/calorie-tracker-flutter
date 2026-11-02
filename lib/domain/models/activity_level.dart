// معاملات مستوى النشاط اليومي المستخدمة لحساب TDEE
enum ActivityLevel {
  sedentary(1.2),
  light(1.375),
  moderate(1.55),
  high(1.725),
  extreme(1.9);

  const ActivityLevel(this.multiplier);

  final double multiplier;
}
