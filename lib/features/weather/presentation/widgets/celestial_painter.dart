import 'package:flutter/material.dart';
import 'package:reinmkg/features/celestial/domain/entities/celestial_entity.dart';
import 'dart:math' as math;

import 'package:reinmkg/features/celestial/domain/entities/celestial_object_entity.dart';

class CelestialPainter extends CustomPainter {
  final CelestialEntity? celestial;
  final DateTime currentTime;
  final double animation;

  CelestialPainter({
    required this.celestial,
    required this.currentTime,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final horizonY = size.height * 0.5;

    _drawGrid(canvas, size, horizonY);

    _drawSunPath(canvas, size, horizonY);

    _drawMoonPath(canvas, size, horizonY);

    _drawTimeMarkers(canvas, size);

    _drawHorizon(canvas, size, horizonY);

    _drawAnimatedPositions(canvas, size, horizonY);
  }

  void _drawGrid(Canvas canvas, Size size, double horizonY) {
    final gridPaint = Paint()
      ..color = Colors.grey[500]!
      ..strokeWidth = 0.1;

    for (int i = 0; i <= 24; i += 2) {
      final x = size.width * (i / 24);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
  }

  void _drawHorizon(Canvas canvas, Size size, double horizonY) {
    canvas.drawLine(
      Offset(0, horizonY),
      Offset(size.width, horizonY),
      Paint()
        ..color = Colors.grey[700]!
        ..strokeWidth = 0.5,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Horizon',
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(size.width - textPainter.width - 8, horizonY - 16),
    );
  }

  void _drawTimeMarkers(Canvas canvas, Size size) {
    final textStyle = TextStyle(color: Colors.grey[600], fontSize: 12);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int hour = 0; hour <= 24; hour += 4) {
      final x = size.width * (hour / 24);

      textPainter.text = TextSpan(
        text: hour == 24 ? '0' : hour.toString(),
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, size.height));
    }
  }

  Path _createCelestialPath(
    Size size,
    double horizonY,
    CelestialObjectEntity? times,
    bool isSun,
  ) {
    final path = Path();
    final points = <Offset>[];

    for (int minute = 0; minute < 24 * 60; minute++) {
      final progress = minute / (24 * 60);
      final x = size.width * progress;

      double amplitude = size.height * 0.4;
      double phase = _calculatePhase(times, isSun);
      double y =
          horizonY - amplitude * math.sin(progress * 2 * math.pi + phase);

      points.add(Offset(x, y));
    }

    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);

      for (int i = 1; i < points.length - 2; i++) {
        final p1 = points[i];
        final p2 = points[i + 1];
        final midPoint = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
        path.quadraticBezierTo(p1.dx, p1.dy, midPoint.dx, midPoint.dy);
      }
    }

    return path;
  }

  void _drawSunPath(Canvas canvas, Size size, double horizonY) {
    final sunGlowPaint = Paint()
      ..color = Colors.yellow.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final sunPathPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.yellow.withValues(alpha: 0.8),
          Colors.orange.withValues(alpha: 0.8),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = _createCelestialPath(size, horizonY, celestial?.sun, true);
    canvas.drawPath(path, sunGlowPaint);
    canvas.drawPath(path, sunPathPaint);
  }

  void _drawMoonPath(Canvas canvas, Size size, double horizonY) {
    final moonGlowPaint = Paint()
      ..color = Colors.blue[200]!.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final moonPathPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.grey[300]!.withValues(alpha: 0.8),
          Colors.blue[200]!.withValues(alpha: 0.8),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = _createCelestialPath(size, horizonY, celestial?.moon, false);
    canvas.drawPath(path, moonGlowPaint);
    canvas.drawPath(path, moonPathPaint);
  }

  double _getMoonPhase(DateTime date) {
    final year = date.year;
    final month = date.month;
    final day = date.day;

    double k = ((year - 2000) * 12.3685) + ((month - 1) + day / 30.0);
    double phase = ((k % 1) + 1) % 1;

    return phase;
  }

  void _drawAnimatedPositions(Canvas canvas, Size size, double horizonY) {
    final currentX = _timeToX(currentTime, size.width);

    if (celestial?.sun?.riseTime != null && celestial?.sun?.setTime != null) {
      final sunY = _calculateCurrentY(
        currentTime,
        celestial?.sun,
        true,
        size,
        horizonY,
      );

      final scale = 1.0 + (math.sin(animation * math.pi * 2) * 0.1);

      final sunGlowPaint = Paint()
        ..color = Colors.yellow.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawCircle(Offset(currentX, sunY), 10 * scale, sunGlowPaint);

      canvas.drawCircle(
        Offset(currentX, sunY),
        10,
        Paint()..color = Colors.yellow,
      );
    }

    if (celestial?.moon?.riseTime != null && celestial?.moon?.setTime != null) {
      final moonY = _calculateCurrentY(
        currentTime,
        celestial?.moon,
        false,
        size,
        horizonY,
      );

      final scale = 1.0 + (math.cos(animation * math.pi * 2) * 0.1);
      final moonCenter = Offset(currentX, moonY);
      final moonRadius = 8 * scale;

      final phase = _getMoonPhase(currentTime);

      _drawMoonPhase(canvas, moonCenter, moonRadius, phase);
    }
  }

  void _drawMoonPhase(
    Canvas canvas,
    Offset center,
    double radius,
    double phase,
  ) {
    final moonPaint = Paint()..color = Colors.grey[300]!;

    final shadowPaint = Paint()..color = Colors.black;

    final moonGlowPaint = Paint()
      ..color = Colors.blue[200]!.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawCircle(center, radius, moonGlowPaint);

    canvas.drawCircle(center, 8, moonPaint);

    phase = (phase % 1 + 1) % 1;

    if (phase <= 0.5) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final path = Path()
        ..addArc(rect, -math.pi / 2, math.pi)
        ..arcTo(rect, math.pi / 2, -math.pi, false);

      final matrix = Matrix4.identity()
        ..translateByDouble(center.dx, center.dy, 0, 1.0)
        ..scaleByDouble(1 - 2 * phase, 1.0, 0, 1.0)
        ..translateByDouble(-center.dx, -center.dy, 0, 1.0);

      path.transform(matrix.storage);
      canvas.drawPath(path, shadowPaint);
    } else {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final path = Path()
        ..addArc(rect, math.pi / 2, math.pi)
        ..arcTo(rect, -math.pi / 2, -math.pi, false);

      final matrix = Matrix4.identity()
        ..translateByDouble(center.dx, center.dy, 0, 1.0)
        ..scaleByDouble(2 * phase - 1, 1.0, 0, 1.0)
        ..translateByDouble(-center.dx, -center.dy, 0, 1.0);

      path.transform(matrix.storage);
      canvas.drawPath(path, shadowPaint);
    }
  }

  double _calculatePhase(CelestialObjectEntity? times, bool isSun) {
    if (times?.riseTime == null || times?.setTime == null) return 0;

    final riseTime = times!.riseTime!;
    final riseProgress = (riseTime.hour * 60 + riseTime.minute) / (24 * 60);

    return -riseProgress * 2 * math.pi;
  }

  double _calculateCurrentY(
    DateTime time,
    CelestialObjectEntity? times,
    bool isSun,
    Size size,
    double horizonY,
  ) {
    final progress = _getTimeProgress(time);
    final phase = _calculatePhase(times, isSun);
    final amplitude = size.height * 0.4;

    return horizonY - amplitude * math.sin((progress * 2 * math.pi) + phase);
  }

  double _getTimeProgress(DateTime time) {
    return (time.hour * 3600 + time.minute * 60 + time.second) / (24 * 3600);
  }

  double _timeToX(DateTime time, double width) {
    return width * _getTimeProgress(time);
  }

  @override
  bool shouldRepaint(CelestialPainter oldDelegate) {
    return currentTime != oldDelegate.currentTime ||
        celestial != oldDelegate.celestial ||
        animation != oldDelegate.animation;
  }
}
