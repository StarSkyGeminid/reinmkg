import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/core/resources/palette.dart';
import 'package:reinmkg/utils/ext/double.dart';
import 'dart:math' as math;

import '../../../../core/enumerate/weather_code.dart';
import '../../../../core/localization/l10n/generated/strings.dart';
import '../../../../domain/entities/weather/weather_entity.dart';
import '../../../cubit/general/settings/settings_cubit.dart';
import '../../../cubit/location/location_cubit.dart';
import '../../../cubit/weather/current_weather/current_weather_cubit.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({super.key});

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
        color: Colors.white.withOpacity(0.01),
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _temperatureView(state.weather),
                  state.status.isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : _currentWeatherIcon(state.weather)
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                // margin: const EdgeInsets.symmetric(horizontal: 2),
                margin: const EdgeInsets.only(top: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: _buildWeatherDetails(weather: state.weather),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWeatherDetails({WeatherEntity? weather}) {
    final humidity = weather?.humidity?.toStringAsFixed(0) ?? '-';
    final windDirection = weather?.windDirection?.name ?? '-';

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _weatherDetail(Symbols.humidity_percentage,
              Strings.of(context).humidity, '$humidity%'),
          const Spacer(),
          windSpeed(weather),
          const Spacer(),
          _weatherDetail(
            Symbols.assistant_navigation_rounded,
            Strings.of(context).windDirection,
            Strings.of(context).windDirectionValue(windDirection),
            angle: weather?.windDirection?.angle ?? 0,
          ),
        ],
      ),
    );
  }

  BlocBuilder<SettingsCubit, SettingsState> windSpeed(WeatherEntity? weather) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final isMetric = state.measurementUnit.isMetric;
        final windSpeed = isMetric
            ? weather?.windSpeed
            : weather?.windSpeed?.kmphToMilePerHour;

        return _weatherDetail(
            Symbols.air,
            Strings.of(context).windSpeed,
            Strings.of(context).speedWithUnit(
              isMetric.toString(),
              '${windSpeed ?? 'nan'}',
              windSpeed ?? 0,
            ));
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
      size: 18.sp,
    );

    return Expanded(
      flex: 9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    color: Palette.subText,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _currentWeatherIcon(WeatherEntity? weather) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state.location == null) return const SizedBox.shrink();

        final isDay = state.location!.isDay();

        return Image(
          image: AssetImage(
            (isDay
                    ? weather?.weatherCode?.iconPathDay
                    : weather?.weatherCode?.iconPathNight) ??
                WeatherType.clearSkies.iconPathDay,
          ),
          width: 0.2.sw,
          height: 0.2.sw,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _weatherDescription(WeatherEntity? weather) {
    return Text(weather?.weatherCode?.name(context) ?? '',
        style: Theme.of(context).textTheme.bodyMedium);
  }

  Widget _temperatureView(WeatherEntity? weather) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final temperature = weather?.temperature?.toDouble() ?? 0;

        return Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '   ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w300),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.top,
                    child: weather != null
                        ? Countup(
                            begin: 0,
                            end: state.measurementUnit.isMetric
                                ? temperature
                                : temperature.celciusToFahrenheit,
                            duration: const Duration(seconds: 1),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(height: 1),
                          )
                        : Text(
                            '-',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                  ),
                  TextSpan(
                    text: state.measurementUnit.isMetric ? '°C' : '°F',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
            _weatherDescription(weather),
          ],
        );
      },
    );
  }
}
