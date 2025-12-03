import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/core/shared/domain/enumerate/weather_type.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';
import 'package:reinmkg/core/shared/features/geojson_data/domain/enumerate/wave_height.dart';
import 'package:reinmkg/core/utils/extension/datetime.dart';

import '../cubit/maritime_weather_detail/maritime_weather_detail_cubit.dart';
import '../../domain/entities/maritime_weather_entity.dart';

class MaritimeWeatherDetails extends StatefulWidget {
  const MaritimeWeatherDetails({
    super.key,
    required this.selectedDay,
    required this.scrollController,
  });

  final int selectedDay;
  final ScrollController scrollController;

  @override
  State<MaritimeWeatherDetails> createState() => _MaritimeWeatherDetailsState();
}

class _MaritimeWeatherDetailsState extends State<MaritimeWeatherDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaritimeWeatherDetailCubit, MaritimeWeatherDetailState>(
      builder: (context, state) {
        if (state is MaritimeWeatherDetailLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state is MaritimeWeatherDetailFailure) {
          return Center(child: Text(state.message));
        }

        if (state is MaritimeWeatherDetailLoaded) {
          final items = state.weatherDetails;
          if (items.isEmpty) {
            return Center(child: Text(Strings.of(context).noDetailsAvailable));
          }

          return SingleChildScrollView(
            controller: widget.scrollController,
            child: _buildDetailCard(context, items[widget.selectedDay]),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildDetailCard(BuildContext context, MaritimeWeatherEntity item) {
    final from = item.validFrom != null
        ? item.validFrom!.toDateTimeString(withTimezone: true)
        : '-';

    final to = item.validTo != null
        ? item.validTo!.toDateTimeString(withTimezone: true)
        : '-';

    final WaveHeight? wave = item.waveHeight;

    final imageProvider = item.weather != null
        ? AssetImage(item.weather!.iconPathDay)
        : null;
    final weatherLabel = item.weather != null
        ? Strings.of(context).wtrType(item.weather!.name)
        : (item.weatherDesc ?? '-');

    final windFrom = item.windFrom != null
        ? Strings.of(context).wdirType(item.windFrom!.name)
        : '-';
    final windTo = item.windTo != null
        ? Strings.of(context).wdirType(item.windTo!.name)
        : '-';
    final windSpeed = (item.windSpeedMin != null && item.windSpeedMax != null)
        ? '${item.windSpeedMin} - ${item.windSpeedMax} kt'
        : (item.windSpeedMax != null ? '${item.windSpeedMax} kt' : '-');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _waveInformation(wave),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        Strings.of(context).validFromTo(from, to),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (imageProvider != null)
                      Image(image: imageProvider, width: 72, height: 72),
                    Text(
                      weatherLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _warning(context, item.warningDesc),
          ),
          Row(
            children: [
              _infoTile(
                Icons.air,
                Strings.of(context).windLabel,
                '$windFrom → $windTo',
                windSpeed,
              ),
              SizedBox(width: 8),
              _weatherDetail(
                Symbols.assistant_navigation_rounded,
                Strings.of(context).windDirectionLabel,
                item.windFrom != null
                    ? Strings.of(context).wdirType(item.windFrom!.name)
                    : '-',
                rotation: item.windFrom?.angle ?? 0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _warning(BuildContext context, String? warningDesc) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Symbols.warning_amber_rounded,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(warningDesc ?? '-', textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }

  Row _waveInformation(WaveHeight? wave) {
    final waveRangeText = wave != null
        ? '${wave.getWaveHeightMin.toStringAsFixed(2)} - ${wave.getWaveHeightMax.toStringAsFixed(2)} m'
        : '-';
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(
            Symbols.waves_rounded,
            size: (Theme.of(context).textTheme.titleLarge?.fontSize ?? 24) * 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              waveRangeText,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              wave != null
                  ? Strings.of(context).waveCategory(wave.selectorKey)
                  : Strings.of(context).notAvailableLabel,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _infoTile(
    IconData icon,
    String label,
    String valueTop,
    String? valueBottom,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                icon,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                valueBottom ?? valueTop,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _weatherDetail(
    IconData iconData,
    String text,
    String value, {
    int? rotation,
  }) {
    final icon = Icon(
      iconData,
      size: 18,
      color: Theme.of(context).colorScheme.primary,
    );

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: rotation != null
                  ? Transform.rotate(
                      angle: rotation * math.pi / 180,
                      child: icon,
                    )
                  : icon,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                text,
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
