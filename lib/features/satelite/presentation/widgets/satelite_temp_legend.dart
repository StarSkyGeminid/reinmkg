import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reinmkg/core/shared/presentation/widgets/legend_painter.dart';
import 'package:reinmkg/core/utils/extension/num_extension.dart';
import 'package:reinmkg/features/general/settings/presentation/cubit/settings_cubit.dart';

class SateliteTempLegend extends StatelessWidget {
  const SateliteTempLegend({super.key});

  @override
  Widget build(BuildContext context) {
    const thresholds = [60.0, 0.0, -21.0, -41.0, -62.0, -100.0];

    return BlocSelector<SettingsCubit, SettingsState, bool>(
      selector: (state) => state is SettingsLoaded ? state.isMetric : true,
      builder: (context, isMetric) {
        List<LegendLabel> labels = [];

        for (final threshold in thresholds) {
          final displayValue = isMetric
              ? threshold
              : threshold.celciusToFahrenheit;

          labels.add(
            LegendLabel(
              text: displayValue.toStringAsFixed(0),
              color: labels.isEmpty ? Colors.white : Colors.black,
            ),
          );
        }

        return CustomPaint(
          painter: LegendPainter(
            colors: const [
              Color(0xFF000000),
              Color(0xFF000000),
              Color(0xFF0A4882),
              Color(0xFF3462B4),
              Color(0xFF4887FF),
              Color(0xFF43B0FF),
              Color(0xFF00C091),
              Color(0xFF00E686),
              Color(0xFF8CFF00),
              Color(0xFF9CD300),
              Color(0xFFC5BB00),
              Color(0xFFCD9A00),
              Color(0xFFFF5D00),
              Color(0xFFFFA000),
              Color(0xFFFFC48D),
              Color(0xFFFFD4B8),
              Color(0xFFFA5858),
              Color(0xFFFE0000),
              Color(0xFFFE0000),
            ],
            labels: labels,
          ),
        );
      },
    );
  }
}
