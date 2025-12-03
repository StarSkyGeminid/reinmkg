import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/core/utils/extension/num_extension.dart';
import 'package:reinmkg/features/general/settings/presentation/cubit/settings_cubit.dart';
import 'dart:math' as math;

import '../../domain/entities/weather_entity.dart';
import '../../../../core/shared/domain/enumerate/weather_type.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';

class CurrentWeather extends StatefulWidget {
  final WeatherEntity? weather;
  final bool isDayTime;

  const CurrentWeather({super.key, this.weather, this.isDayTime = true});

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return _weatherView();
  }

  Widget _weatherView() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.01),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  _temperatureView(widget.weather),
                  _weatherDescription(widget.weather?.weatherCode),
                ],
              ),
              widget.weather == null
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : _currentWeatherIcon(widget.weather, widget.isDayTime),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            margin: const EdgeInsets.only(top: 16.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(10),
            ),
            child: _buildWeatherDetails(weather: widget.weather),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails({WeatherEntity? weather}) {
    final humidity = weather?.humidity?.toStringAsFixed(0) ?? '-';
    final windHeading = weather != null && weather.windDirection != null
        ? Strings.of(context).wdirType(weather.windDirection!.name)
        : '-';

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _weatherDetail(
            Symbols.humidity_percentage,
            Strings.of(context).humidityLabel,
            '$humidity%',
          ),
          const Spacer(),
          windSpeed(weather),
          const Spacer(),
          _weatherDetail(
            Symbols.assistant_navigation_rounded,
            Strings.of(context).windDirectionLabel,
            windHeading,
            rotation: weather?.windDirection?.angle ?? 0,
          ),
        ],
      ),
    );
  }

  Widget windSpeed(WeatherEntity? weather) {
    return BlocSelector<SettingsCubit, SettingsState, bool>(
      selector: (state) => state is SettingsLoaded ? state.isMetric : true,
      builder: (context, isMetric) {
        final raw = weather?.windSpeed;
        final display = raw == null
            ? null
            : (isMetric ? raw : raw.kmphToMilePerHour);
        final unitLabel = isMetric ? 'km/h' : 'mph';

        return _weatherDetail(
          Symbols.air,
          Strings.of(context).windLabel,
          "${display?.toStringAsFixed(1) ?? '-'} $unitLabel",
        );
      },
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
      flex: 9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: rotation != null
                ? Transform.rotate(angle: rotation * math.pi / 180, child: icon)
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
    );
  }

  Widget _currentWeatherIcon(WeatherEntity? weather, bool isDay) {
    if (weather == null) return const SizedBox.shrink();

    return Image(
      image: AssetImage(
        (isDay
                ? weather.weatherCode?.iconPathDay
                : weather.weatherCode?.iconPathNight) ??
            WeatherType.clearSkies.iconPathDay,
      ),
      width: 48,
      height: 48,
      alignment: Alignment.center,
    );
  }

  Widget _weatherDescription(WeatherType? weather) {
    return Text(
      weather != null ? Strings.of(context).wtrType(weather.name) : '',
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Widget _temperatureView(WeatherEntity? weather) {
    final double? temperature = weather?.temperature?.toDouble();

    return BlocSelector<SettingsCubit, SettingsState, bool>(
      selector: (state) => state is SettingsLoaded ? state.isMetric : true,
      builder: (context, isMetric) {
        final displayTemp = temperature == null
            ? null
            : (isMetric ? temperature : temperature.celciusToFahrenheit);
        final unitLabel = isMetric ? '°C' : '°F';
        final tempText = displayTemp != null
            ? displayTemp.toStringAsFixed(0)
            : '-';

        return RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.top,
                child: Countup(
                  begin: 0,
                  end: double.tryParse(tempText) ?? 0,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              TextSpan(text: unitLabel),
            ],
          ),
        );
      },
    );
  }
}
