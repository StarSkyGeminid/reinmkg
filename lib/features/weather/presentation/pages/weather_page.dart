import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../general/location/presentation/cubit/location_cubit.dart';
import '../../../../core/localization/l10n/generated/strings.dart';
import '../cubit/cubit.dart';
import '../widgets/widgets.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<LocationCubit>().getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  if (state is LocationLoaded) {
                    return WeatherLocation(
                      locationName: state.location.subdistrict,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8),
            child: BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                bool isDayTime = true;

                if (state is LocationLoaded) {
                  isDayTime = state.location.isDay();
                }

                return BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
                  builder: (context, state) {
                    final weather = state is CurrentWeatherLoaded
                        ? state.weather
                        : null;

                    return CurrentWeather(
                      weather: weather,
                      isDayTime: isDayTime,
                    );
                  },
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 32.0),
            child: Text(
              Strings.of(context).dailyForecastLabel,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: BlocBuilder<DailyWeatherCubit, DailyWeatherState>(
              builder: (context, state) {
                final weathers = state is DailyWeatherLoaded
                    ? state.weathers
                    : null;

                return DailyWeather(weathers: weathers);
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 32.0),
            child: Text(
              Strings.of(context).celestialDataLabel,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: CelestialData(),
          ),
        ),
      ],
    );
  }
}
