import 'package:flutter/material.dart';

class LegendPainter extends CustomPainter {
  final List<Color> colors;
  final List<LegendLabel> labels;

  LegendPainter({required this.colors, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    final List<double> stops = [];

    if (colors.length == 1) {
      stops.add(0.0);
    } else {
      for (int i = 0; i < colors.length; i++) {
        stops.add(i / (colors.length - 1));
      }
    }
    final paint = Paint()
      ..shader = LinearGradient(
        colors: colors,
        stops: stops,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final borderPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(20),
    );
    canvas.drawRRect(rect, paint);
    canvas.drawRRect(rect, borderPaint);

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final step = size.width / labels.length;

    for (int i = 0; i < labels.length; i++) {
      textPainter.text = TextSpan(
        text: labels[i].text,
        style: TextStyle(
          color: labels[i].color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
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

class LegendLabel {
  final String text;
  final Color color;

  const LegendLabel({required this.text, this.color = Colors.black});
}
