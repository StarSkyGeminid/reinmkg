import 'package:daylight/daylight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';
import 'package:reinmkg/features/cubit/cubit.dart';
import 'package:intl/intl.dart';
import 'package:reinmkg/utils/ext/double.dart';

import 'weather_chart_painter.dart';

class TodayWeather extends StatefulWidget {
  const TodayWeather({super.key});

  @override
  State<TodayWeather> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends State<TodayWeather> {
  late final LatLng coordinate;

  @override
  void initState() {
    super.initState();

    coordinate =
        BlocProvider.of<LocationCubit>(context).state.location?.toLatLng() ??
            const LatLng(-6.175307, 106.8249059);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return BlocBuilder<WeeklyWeatherCubit, WeeklyWeatherState>(
      builder: (context, state) {
        final weathers = state.weathers;

        if (!state.status.isSuccess) return const SizedBox.shrink();

        if (weathers == null) return const SizedBox.shrink();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: AbsorbPointer(
            child: SizedBox(
              height: 150.h,
              child: LayoutBuilder(builder: (context, constrains) {
                return CustomPaint(
                  foregroundPainter: WeatherChartPainter(
                    data: state.weathers!,
                  ),
                  child: _buildDesc(weathers),
                );
              }),
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

        var day =
            isDay(weather.time!, coordinate.latitude, coordinate.longitude);

        return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            final isMetric = state.measurementUnit.isMetric;

            var temperature = isMetric
                ? weather.temperature
                : weather.temperature!.celciusToFahrenheit;
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
                    width: 32.sp,
                    height: 32.sp,
                  ),
                  Text(
                    '${temperature?.toStringAsFixed(0) ?? '-'}°',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Palette.subText,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    DateFormat('kk:mm', ).format(weather.time!),
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
      DateTime dateTime, double latitude, double longitude) {
    final currentLocation = DaylightLocation(latitude, longitude);

    final calculator = DaylightCalculator(currentLocation);
    return calculator.calculateForDay(dateTime, Zenith.official);
  }

  bool isDay(DateTime dateTime, double latitude, double longitude) {
    final dailyResults = dailyLights(dateTime, latitude, longitude);

    if (dailyResults == null) return true;

    final isDay = dateTime.isAfter(dailyResults.sunrise!.toLocal()) &&
        dateTime.isBefore(dailyResults.sunset!.toLocal());
    return isDay;
  }
}
