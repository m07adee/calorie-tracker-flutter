import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/nutrient_colors.dart';
import '../../../l10n/app_localizations.dart';

const _animationDuration = Duration(milliseconds: 900);

/// حلقة السعرات: المتبقي في المنتصف، والمستهدف والمستهلك أسفلها
class CalorieRing extends StatelessWidget {
  const CalorieRing({
    super.key,
    required this.targetCalories,
    required this.consumedCalories,
    this.size = 220,
    this.strokeWidth = 18,
  });

  final int targetCalories;
  final int consumedCalories;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final nutrients = theme.nutrients;
    final remaining = targetCalories - consumedCalories;
    final isOver = remaining < 0;
    final progress = targetCalories > 0 ? (consumedCalories / targetCalories).clamp(0.0, 1.0) : 0.0;
    final ringColor = isOver ? theme.colorScheme.error : nutrients.calories;

    return Column(
      children: [
        SizedBox.square(
          dimension: size,
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: progress),
            duration: _animationDuration,
            curve: Curves.easeOutCubic,
            builder: (context, value, _) => CustomPaint(
              painter: _RingPainter(
                progress: value,
                color: ringColor,
                trackColor: nutrients.track,
                strokeWidth: strokeWidth,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _AnimatedNumber(
                      value: remaining.abs(),
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: isOver ? theme.colorScheme.error : theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      isOver ? l10n.ringOver : l10n.ringRemaining,
                      style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _RingStat(label: l10n.ringTarget, value: targetCalories),
            _RingStat(label: l10n.ringConsumed, value: consumedCalories),
          ],
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(strokeWidth / 2, strokeWidth / 2) &
        Size(size.width - strokeWidth, size.height - strokeWidth);
    final track = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(rect, 0, math.pi * 2, false, track);

    if (progress <= 0) return;
    final arc = Paint()
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: math.pi * 1.5,
        colors: [color.withValues(alpha: 0.6), color],
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas.drawArc(rect, -math.pi / 2, math.pi * 2 * progress, false, arc);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.color != color || old.trackColor != trackColor;
}

class _RingStat extends StatelessWidget {
  const _RingStat({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _AnimatedNumber(value: value, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        Text(label, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }
}

class _AnimatedNumber extends StatelessWidget {
  const _AnimatedNumber({required this.value, this.style});

  final int value;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: value.toDouble()),
      duration: _animationDuration,
      curve: Curves.easeOutCubic,
      builder: (context, animated, _) => Text(animated.round().toString(), style: style),
    );
  }
}
