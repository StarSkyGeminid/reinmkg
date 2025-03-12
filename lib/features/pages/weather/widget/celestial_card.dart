// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../domain/entities/celestial/celestial_entity.dart';
import 'celestial_painter.dart';

class AnimatedCelestialPathGraph extends StatefulWidget {
  final CelestialEntity? sun;
  final CelestialEntity? moon;
  final DateTime currentTime;

  const AnimatedCelestialPathGraph({
    super.key,
    this.sun,
    this.moon,
    required this.currentTime,
  });

  @override
  AnimatedCelestialPathGraphState createState() =>
      AnimatedCelestialPathGraphState();
}

class AnimatedCelestialPathGraphState extends State<AnimatedCelestialPathGraph>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: CelestialPainter(
            sun: widget.sun,
            moon: widget.moon,
            currentTime: widget.currentTime,
            animation: _controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}
