import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/core/utils/extension/num_extension.dart';
import 'dart:math' as math;

import 'package:reinmkg/features/general/settings/presentation/cubit/settings_cubit.dart';
import 'package:reinmkg/core/shared/domain/enumerate/weather_type.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({
    super.key,
    this.temperature,
    this.humidity,
    this.windSpeed,
    this.windDirection,
    this.windDirectionAngle,
    this.weatherDescription,
    this.weatherIconPath,
  });

  final double? temperature;
  final double? humidity;
  final double? windSpeed;
  final String? windDirection;
  final int? windDirectionAngle;
  final String? weatherDescription;
  final String? weatherIconPath;

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
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.01),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  _temperatureView(widget.temperature),
                  _weatherDescription(widget.weatherDescription),
                ],
              ),
              Expanded(
                child: widget.temperature == null
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : _currentWeatherIcon(widget.weatherIconPath),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: _buildWeatherDetails(
              temperature: widget.temperature,
              humidity: widget.humidity,
              windSpeed: widget.windSpeed,
              windDirection: widget.windDirection,
              windDirectionAngle: widget.windDirectionAngle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails({
    double? temperature,
    double? humidity,
    double? windSpeed,
    int? windDirectionAngle,
    String? windDirection,
  }) {
    final humidityStr = humidity?.toStringAsFixed(0) ?? '-';
    final windDirectionStr = windDirection ?? '-';

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _weatherDetail(
            Symbols.humidity_percentage,
            Strings.of(context).humidityLabel,
            '$humidityStr%',
          ),
          _windSpeed(windSpeed),
          _weatherDetail(
            Symbols.assistant_navigation_rounded,
            Strings.of(context).windDirectionLabel,
            windDirectionStr,
            angle: windDirectionAngle,
          ),
        ],
      ),
    );
  }

  Widget _windSpeed(double? windSpeed) {
    return BlocSelector<SettingsCubit, SettingsState, bool>(
      selector: (state) => state is SettingsLoaded ? state.isMetric : true,
      builder: (context, isMetric) {
        final raw = windSpeed;
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
    int? angle,
  }) {
    final icon = Icon(
      iconData,
      size: 18,
      color: Theme.of(context).colorScheme.primary,
    );

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: angle != null
                  ? Transform.rotate(angle: angle * math.pi / 180, child: icon)
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

  Widget _currentWeatherIcon(String? weatherIconPath) {
    return Image(
      image: AssetImage(weatherIconPath ?? WeatherType.clearSkies.iconPathDay),
      width: 136,
      height: 136,
      alignment: Alignment.topRight,
    );
  }

  Widget _weatherDescription(String? weatherDescription) {
    return Text(
      weatherDescription ?? '',
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _temperatureView(double? temperature) {
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
                child: displayTemp != null
                    ? Countup(
                        begin: 0,
                        end: double.tryParse(tempText) ?? 0,
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    : Text(
                        tempText,
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
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
