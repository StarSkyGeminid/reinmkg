import 'package:flutter/material.dart';
import 'package:reinmkg/features/weather/domain/entities/weather_entity.dart';

class WeatherChartPainter extends CustomPainter {
  final List<WeatherEntity> data;

  WeatherChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    const double width = 100;

    final maxTemp = data
        .map((e) => e.temperature!)
        .reduce((a, b) => a > b ? a : b);
    final minTemp = data
        .map((e) => e.temperature!)
        .reduce((a, b) => a < b ? a : b);

    final heightRatio = size.height / (maxTemp - minTemp) * 0.38;

    List<Offset> points = [];

    final y =
        size.height - ((data[0].temperature! - minTemp) * heightRatio) - 32;

    points.add(Offset(0, y));

    for (var i = 0; i < data.length; i++) {
      final x = i * width + width / 2;
      final y =
          size.height - ((data[i].temperature! - minTemp) * heightRatio) - 32;

      points.add(Offset(x, y));
    }

    path.moveTo(points[0].dx, points[0].dy);

    for (var i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];

      final controlPoint1 = Offset(
        current.dx + (next.dx - current.dx) / 2,
        current.dy,
      );
      final controlPoint2 = Offset(
        current.dx + (next.dx - current.dx) / 2,
        next.dy,
      );

      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        next.dx,
        next.dy,
      );
    }

    canvas.drawPath(path, paint);

    final smallPointPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final largePointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    for (int i = 1; i < points.length; i++) {
      var point = points[i];

      canvas.drawCircle(point, 8, shadowPaint);
      canvas.drawCircle(point, 6, largePointPaint);
      canvas.drawCircle(point, 4, smallPointPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
