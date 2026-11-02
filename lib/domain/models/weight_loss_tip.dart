// طبيعة النصيحة لتحديد شكل عرضها (تنبيه، تشجيع، معلومة)
enum TipTone { warning, positive, info }

enum WeightLossTip {
  // نصائح ذكية مرتبطة باستهلاك اليوم
  completeProfile(TipTone.info),
  startWithProteinBreakfast(TipTone.info),
  noMealsYet(TipTone.warning),
  overCalories(TipTone.warning),
  lowProtein(TipTone.warning),
  highFats(TipTone.warning),
  highCarbs(TipTone.warning),
  underEating(TipTone.warning),
  closeToTarget(TipTone.positive),
  onTrack(TipTone.positive),
  drinkWater(TipTone.info),

  // نصائح عامة لتسريع خسارة الوزن ورفع الحرق
  dailyWalking(TipTone.info),
  strengthTraining(TipTone.info),
  sleepWell(TipTone.info),
  eatFiber(TipTone.info),
  proteinEveryMeal(TipTone.info),
  avoidSugaryDrinks(TipTone.info),
  eatSlowly(TipTone.info),
  waterBeforeMeals(TipTone.info),
  moveMoreDaily(TipTone.info);

  const WeightLossTip(this.tone);

  final TipTone tone;
}

class SmartTips {
  const SmartTips({required this.primary, required this.contextual, required this.general});

  final WeightLossTip primary;
  final List<WeightLossTip> contextual;
  final List<WeightLossTip> general;
}
