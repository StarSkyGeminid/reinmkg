import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reinmkg/core/shared/presentation/widgets/legend_painter.dart';
import 'package:reinmkg/core/utils/extension/num_extension.dart';

import '../../../general/settings/presentation/cubit/settings_cubit.dart';

class RadarMmLegend extends StatelessWidget {
  const RadarMmLegend({super.key});

  @override
  Widget build(BuildContext context) {
    const thresholds = [1.0, 2.0, 5.0, 7.0, 9.0, 10.0, 12.0, 15.0, 50.0, 100.0];

    return BlocSelector<SettingsCubit, SettingsState, bool>(
      selector: (state) => state is SettingsLoaded ? state.isMetric : true,
      builder: (context, isMetric) {
        List<LegendLabel> labels = [];

        for (final threshold in thresholds) {
          final displayValue = isMetric
              ? threshold
              : threshold.milimetersToInches;

          labels.add(
            LegendLabel(
              text: displayValue.toStringAsFixed(2),
            ),
          );
        }
        return CustomPaint(
          painter: LegendPainter(
            colors: const [
              Color(0xFF0000C6),
              Color(0xFF0079FF),
              Color(0xFF32C8FF),
              Color(0xFF78EBFF),
              Color(0xFFFFFFFF),
              Color(0xFFFFF7C0),
              Color(0xFFFFE500),
              Color(0xFFFF7300),
              Color(0xFFFF3F00),
              Color(0xFFC80000),
              Color(0xFF7F0000),
            ],
            labels: labels,
          ),
        );
      },
    );
  }
}
