import 'package:flutter/material.dart';
import 'dart:math' as math;

class MoonPhasePainter extends CustomPainter {
  final double fraction;
  final double phase;

  MoonPhasePainter({
    required this.fraction,
    required this.phase,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    var yellow = Colors.yellow[300]!.withValues(alpha: 0.3);
    var grey = Colors.black.withValues(alpha: 0.75);

    final rect = Rect.fromCircle(center: center, radius: radius);

    final gradient = LinearGradient(
      colors: phase < 0.5 ? [grey, yellow] : [yellow, grey],
      stops: phase < 0.5
          ? [1 - fraction - 0.1 * fraction, 1 - fraction + 0.1 / fraction]
          : [fraction - 0.1 / fraction, fraction + 0.1 * fraction],
    );

    paint.shader = gradient.createShader(rect);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(MoonPhasePainter oldDelegate) {
    return oldDelegate.fraction != fraction || oldDelegate.phase != phase;
  }
}
