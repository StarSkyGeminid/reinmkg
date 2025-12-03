import 'package:daylight/daylight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:reinmkg/core/shared/domain/enumerate/weather_type.dart';
import 'package:reinmkg/core/utils/extension/num_extension.dart';
import 'package:reinmkg/features/general/settings/presentation/cubit/settings_cubit.dart';
import 'package:reinmkg/features/weather/domain/entities/weather_entity.dart';
import 'package:reinmkg/features/weather/presentation/cubit/weekly_weather/weekly_weather_cubit.dart';

import 'weather_chart_painter.dart';

class TodayWeather extends StatefulWidget {
  const TodayWeather({super.key, required this.coordinate});

  final LatLng coordinate;

  @override
  State<TodayWeather> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends State<TodayWeather> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return BlocSelector<
      WeeklyWeatherCubit,
      WeeklyWeatherState,
      List<WeatherEntity>?
    >(
      selector: (state) => state is WeeklyWeatherLoaded ? state.weathers : null,
      builder: (context, state) {
        if (state == null) return const SizedBox.shrink();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: AbsorbPointer(
            child: SizedBox(
              height: 150,
              child: LayoutBuilder(
                builder: (context, constrains) {
                  return CustomPaint(
                    foregroundPainter: WeatherChartPainter(data: state),
                    child: _buildDesc(state),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  ListView _buildDesc(List<WeatherEntity> weathers) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: weathers.length,
      itemBuilder: (context, index) {
        final weather = weathers[index];

        var day = isDay(
          weather.time!,
          widget.coordinate.latitude,
          widget.coordinate.longitude,
        );

        return BlocSelector<SettingsCubit, SettingsState, bool>(
          selector: (state) => state is SettingsLoaded ? state.isMetric : true,
          builder: (context, isMetric) {
            var displayTemp = isMetric
                ? weather.temperature
                : weather.temperature!.celciusToFahrenheit;
            final tempText = displayTemp != null
                ? displayTemp.toStringAsFixed(0)
                : '-';

            return SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    day
                        ? weather.weatherCode!.iconPathDay
                        : weather.weatherCode!.iconPathNight,
                    width: 32,
                    height: 32,
                  ),
                  Text(
                    '$tempText°',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    DateFormat('kk:mm').format(weather.time!),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  DaylightResult? dailyLights(
    DateTime dateTime,
    double latitude,
    double longitude,
  ) {
    final currentLocation = DaylightLocation(latitude, longitude);

    final calculator = DaylightCalculator(currentLocation);
    return calculator.calculateForDay(dateTime, Zenith.official);
  }

  bool isDay(DateTime dateTime, double latitude, double longitude) {
    final dailyResults = dailyLights(dateTime, latitude, longitude);

    if (dailyResults == null) return true;

    final isDay =
        dateTime.isAfter(dailyResults.sunrise!.toLocal()) &&
        dateTime.isBefore(dailyResults.sunset!.toLocal());
    return isDay;
  }
}
