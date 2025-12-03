import 'package:flutter/material.dart';
import 'package:reinmkg/core/shared/presentation/widgets/legend_painter.dart';

class RadarDbzLegend extends StatelessWidget {
  const RadarDbzLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LegendPainter(
        colors: const [
          Color(0xFF02C2EF),
          Color(0xFF004AF4),
          Color(0xFF007F80),
          Color(0xFF00E500),
          Color(0xFF00B000),
          Color(0xFF81CB00),
          Color(0xFFFFE200),
          Color(0xFFFFA000),
          Color(0xFFFF3A00),
          Color(0xFFFF3A00),
          Color(0xFFE20000),
          Color(0xFFAF0000),
          Color(0xFFC40080),
          Color(0xFFB702E8),
        ],
        labels: const [
          LegendLabel(text: "10"),
          LegendLabel(text: "15"),
          LegendLabel(text: "20"),
          LegendLabel(text: "25"),
          LegendLabel(text: "30"),
          LegendLabel(text: "35"),
          LegendLabel(text: "40"),
          LegendLabel(text: "45"),
          LegendLabel(text: "50"),
          LegendLabel(text: "55"),
          LegendLabel(text: "60"),
          LegendLabel(text: "65"),
        ],
      ),
    );
  }
}
