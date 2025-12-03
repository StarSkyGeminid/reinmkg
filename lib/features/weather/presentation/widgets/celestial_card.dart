import 'package:flutter/material.dart';

import '../../../celestial/domain/entities/celestial_entity.dart';
import 'celestial_painter.dart';

class AnimatedCelestialPathGraph extends StatefulWidget {
  final CelestialEntity? celestial;
  final DateTime currentTime;

  const AnimatedCelestialPathGraph({
    super.key,
    this.celestial,
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
            celestial: widget.celestial,
            currentTime: widget.currentTime,
            animation: _controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}
