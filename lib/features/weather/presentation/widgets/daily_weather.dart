import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reinmkg/core/utils/extension/num_extension.dart';
import '../../../../core/localization/l10n/generated/strings.dart';

import '../../../general/settings/presentation/cubit/settings_cubit.dart';
import '../../domain/entities/daily_weather_entity.dart';
import '../../../../core/shared/domain/enumerate/weather_type.dart';

class DailyWeather extends StatefulWidget {
  const DailyWeather({super.key, this.weathers});

  final List<DailyWeatherEntity>? weathers;

  @override
  State<DailyWeather> createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.01),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 8.0),
        itemBuilder: (context, index) => tile(widget.weathers![index]),
        itemCount: widget.weathers?.length ?? 0,
      ),
    );
  }

  Widget tile(DailyWeatherEntity weather) {
    return BlocSelector<SettingsCubit, SettingsState, bool>(
      selector: (state) => state is SettingsLoaded ? state.isMetric : true,
      builder: (context, isMetric) {
        return Container(
          padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat(
                  'EEEE',
                  Strings.of(context).localeName,
                ).format(weather.time!).toString(),
              ),
              const Spacer(),
              Image(
                image: AssetImage(
                  weather.weatherCode?.iconPathDay ??
                      WeatherType.clearSkies.iconPathDay,
                ),
                width: 24,
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '${isMetric ? weather.minTemp! : weather.minTemp!.celciusToFahrenheit.round()}°',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '${isMetric ? weather.maxTemp! : weather.maxTemp!.celciusToFahrenheit.round()}°',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
