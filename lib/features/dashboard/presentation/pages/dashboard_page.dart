import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:intl/intl.dart';
import 'package:reinmkg/core/shared/domain/enumerate/weather_type.dart';
import 'package:reinmkg/features/earthquake/presentation/cubit/earthquake/earthquake_cubit.dart';
import 'package:reinmkg/features/general/location/domain/entities/location_entity.dart';
import 'package:reinmkg/features/general/location/presentation/cubit/location_cubit.dart';
import 'package:reinmkg/features/weather/domain/entities/weather_entity.dart';
import 'package:reinmkg/features/weather/presentation/cubit/current_weather/current_weather_cubit.dart';
import '../widgets/local_alerts.dart';

import '../widgets/widgets.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<void> _handleRefresh() {
    BlocProvider.of<CurrentWeatherCubit>(context).getCurrentWeather();

    BlocProvider.of<EarthquakeCubit>(context).getLastEarthquake();
    BlocProvider.of<EarthquakeCubit>(context).getRecentEarthquake();

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: _handleRefresh,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: _currentData(context),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                child: BlocSelector<LocationCubit, LocationState, bool>(
                  selector: (state) =>
                      state is LocationLoaded ? state.location.isDay() : true,
                  builder: (context, isDay) {
                    return BlocSelector<
                      CurrentWeatherCubit,
                      CurrentWeatherState,
                      WeatherEntity?
                    >(
                      selector: (state) =>
                          state is CurrentWeatherLoaded ? state.weather : null,
                      builder: (context, state) {
                        return CurrentWeather(
                          temperature: state?.temperature,
                          humidity: state?.humidity,
                          windSpeed: state?.windSpeed,
                          windDirection: Strings.of(
                            context,
                          ).wdirType(state?.windDirection?.name ?? ''),
                          windDirectionAngle: state?.windDirection?.angle ?? 0,
                          weatherDescription: state?.weatherCode != null
                              ? Strings.of(
                                  context,
                                ).wtrType(state!.weatherCode!.name)
                              : null,
                          weatherIconPath: isDay
                              ? state?.weatherCode?.iconPathDay
                              : state?.weatherCode?.iconPathNight,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverToBoxAdapter(child: const LocalAlertsWidget()),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              sliver: SliverToBoxAdapter(child: WeatherMenu()),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  Strings.of(context).forecastWeatherLabel,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 16),
                child: BlocSelector<LocationCubit, LocationState, LatLng?>(
                  selector: (state) => state is LocationLoaded
                      ? state.location.toLatLng()
                      : null,
                  builder: (context, state) {
                    return TodayWeather(coordinate: state ?? LatLng(0, 0));
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 16),
                child: LastEarthquakeFelt(),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: RecentEarthquake(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _currentData(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Strings.of(context).dashboardNowLabel,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            BlocSelector<
              CurrentWeatherCubit,
              CurrentWeatherState,
              WeatherEntity?
            >(
              selector: (state) =>
                  state is CurrentWeatherLoaded ? state.weather : null,
              builder: (context, weather) {
                return _currentDate(weather?.time);
              },
            ),
          ],
        ),
        _buildLocationInfo(),
      ],
    );
  }

  Text _currentDate(DateTime? time) {
    final DateFormat format1 = DateFormat(
      'EEE, d MMM ',
      Strings.of(context).localeName,
    );

    return Text(
      time != null ? format1.format(time) : '-',
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).disabledColor),
    );
  }

  Widget _buildLocationInfo() {
    return BlocSelector<LocationCubit, LocationState, LocationEntity?>(
      selector: (state) => state is LocationLoaded ? state.location : null,
      builder: (context, location) {
        if (location == null) {
          return Text(
            '-',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).disabledColor,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Icon(
                        Symbols.location_on,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: location.subdistrict!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              location.regency!,
              textScaler: const TextScaler.linear(1),
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).disabledColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
