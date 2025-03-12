import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/features/features.dart';
import 'package:intl/intl.dart';

import 'widget/widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<void> _handleRefresh() {
    BlocProvider.of<RecentEarthquakeBloc>(context)
        .add(const RecentEarthquakeEvent.started());

    BlocProvider.of<LastEarthquakeFeltBloc>(context)
        .add(const LastEarthquakeFeltEvent.started());

    final locationId =
        BlocProvider.of<LocationCubit>(context).state.location?.administration?.adm4;

    if (locationId == null) return Future.value();

    BlocProvider.of<CurrentWeatherCubit>(context).getCurrentWeather(locationId);

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
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                  child: _currentData(context),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
                child: const CurrentWeather(),
              ),
            ),
            // SliverToBoxAdapter(child: SizedBox(height: 0.05.sh)),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              sliver: const SliverToBoxAdapter(child: WeatherMenu()),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Text(
                  Strings.of(context).weatherForecast,
                  // 'Prakiraan Cuaca',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: const TodayWeather(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: const LastEarthquakeFelt(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                child: const RecentEarthquake(),
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
              Strings.of(context).now,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
              builder: (context, state) {
                return _currentDate(state.weather?.time);
              },
            )
          ],
        ),
        _buildLocationInfo(),
      ],
    );
  }

  Text _currentDate(DateTime? time) {
    final DateFormat format1 =
        DateFormat('EEE, d MMM ', Strings.of(context).localeName);

    return Text(
      time != null ? format1.format(time) : '-',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Palette.subText,
          ),
    );
  }

  Widget _buildLocationInfo() {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state.location == null) {
          return Text(
            '-',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Palette.subText),
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
                        size: 16.sp,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: state.location!.subdistrict!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text(
              state.location!.regency!,
              textScaler: const TextScaler.linear(1),
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Palette.subText),
            ),
          ],
        );
      },
    );
  }
}
