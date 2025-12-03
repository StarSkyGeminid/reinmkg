import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';

import 'package:reinmkg/features/general/settings/presentation/cubit/settings_cubit.dart';

class EarthquakeLegend extends StatefulWidget {
  const EarthquakeLegend({super.key});

  @override
  State<EarthquakeLegend> createState() => _EarthquakeLegendState();
}

class _EarthquakeLegendState extends State<EarthquakeLegend> {
  final List<int> magnitude = [1, 2, 3, 4, 5, 6, 7, 8];
  final List<double> depthImperial = [31.07, 62.14, 155.34, 372.82, 372.82];
  final List<double> depthMetric = [50, 100, 250, 600, 600];

  late bool isMetric;

  @override
  void initState() {
    super.initState();

    final state = BlocProvider.of<SettingsCubit>(context).state;
    isMetric = (state is SettingsLoaded) ? state.isMetric : true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        isMetric = (state is SettingsLoaded) ? state.isMetric : isMetric;

        return Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.7),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Strings.of(context).legendLabel,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '${Strings.of(context).earthquakeMagnitude} (${Strings.of(context).magnitudeUnit})',
                ),
                const SizedBox(height: 4),
                _buildMarkerSize(),
                const SizedBox(height: 8),
                Text(
                  '${Strings.of(context).earthquakeDepth} (${isMetric ? Strings.of(context).unitKm : Strings.of(context).unitMiles})',
                ),
                const SizedBox(height: 4),
                _buildMarkerColor(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMarkerColor() {
    final depth = isMetric ? depthMetric : depthImperial;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: depth
              .take(2)
              .map((e) => _buildDepthMarker(e, false))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: depth
              .getRange(2, 4)
              .map((e) => _buildDepthMarker(e, false))
              .toList(),
        ),
        _buildDepthMarker(depth.last, true),
      ],
    );
  }

  Widget _buildDepthMarker(double depth, bool isLast) {
    final symbol = isLast ? '>' : '<=';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(),
              color: _getMarkerColor(!isLast ? depth : depth + 1),
            ),
          ),
          Text('$symbol${depth.toInt()}'),
        ],
      ),
    );
  }

  Widget _buildMarkerSize() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: magnitude
              .take(5)
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _buildMagnitudeMarker(e, false),
                ),
              )
              .toList(),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: magnitude
              .skip(5)
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _buildMagnitudeMarker(e, e == magnitude.last),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Column _buildMagnitudeMarker(int magnitude, bool isLast) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: _getMarkerSize(magnitude).toDouble(),
          height: _getMarkerSize(magnitude).toDouble(),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withValues(alpha: 0.2),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.8)),
          ),
        ),
        Text('$magnitude${isLast ? '+' : ''}'),
      ],
    );
  }

  Color _getMarkerColor(double depth) {
    switch (depth) {
      case <= 50:
        return Colors.red;
      case <= 100:
        return Colors.orange;
      case <= 250:
        return Colors.yellow;
      case <= 600:
        return Colors.green;
      case > 600:
        return Colors.blue;
      default:
        return Colors.blue;
    }
  }

  int _getMarkerSize(int magnitude) {
    return magnitude * 4;
  }
}
