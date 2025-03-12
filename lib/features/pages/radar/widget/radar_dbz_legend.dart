import 'dart:ui';

import 'package:flutter/material.dart';

class RadarDbzLegend extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Colors.cyan,
          Colors.blue,
          Colors.green,
          Colors.yellow,
          Colors.orange,
          Colors.red,
          Colors.purple,
        ],
        stops: [0.0, 0.16, 0.33, 0.5, 0.66, 0.83, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final borderPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    // Draw rounded rectangle with gradient
    final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(20));
    canvas.drawRRect(rect, paint);
    canvas.drawRRect(rect, borderPaint);

    // Draw labels
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final labels = [
      "10",
      "15",
      "20",
      "25",
      "30",
      "35",
      "40",
      "45",
      "50",
      "55",
      "60",
      "65",
    ];
    final step = size.width / labels.length;

    for (int i = 0; i < labels.length; i++) {
      textPainter.text = TextSpan(
        text: labels[i],
        style: const TextStyle(
          color: Colors.black,
          fontSize: 8,
          fontWeight: FontWeight.w500,
        ),
      );
      textPainter.layout();

      final offset = Offset(
        step * i + step / 2 - textPainter.width / 2,
        size.height / 2 - textPainter.height / 2,
      );
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
