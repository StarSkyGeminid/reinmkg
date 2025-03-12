import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reinmkg/core/core.dart';
import 'package:intl/intl.dart';

import '../../../../domain/domain.dart';
import '../../../cubit/cubit.dart';

class DailyWeather extends StatefulWidget {
  const DailyWeather({super.key});

  @override
  State<DailyWeather> createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return BlocBuilder<DailyWeatherCubit, DailyWeatherState>(
      builder: (context, state) {
        if (!state.status.isSuccess) return const SizedBox.shrink();

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          margin: const EdgeInsets.symmetric(horizontal: 16).w,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.01),
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // padding: const EdgeInsets.only(bottom: 16.0),
            itemBuilder: (context, index) => _buildCard(state.weathers![index]),
            itemCount: state.weathers?.length ?? 0,
          ),
        );
      },
    );
  }

  Widget _buildCard(DailyWeatherEntity weather) {
    return Container(
      padding: const EdgeInsets.only(
        // right: 24.r,
        top: 6.0,
        bottom: 6.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('EEEE', Strings.of(context).localeName)
                .format(weather.time!)
                .toString(),
          ),
          const Spacer(),
          BlocBuilder<LocationCubit, LocationState>(
            builder: (context, state) {
              if (!state.status.isSuccess) return const SizedBox.shrink();

              final isDay = state.location!.isDay();

              return Image(
                image: AssetImage(
                  (isDay
                          ? weather.weatherCode?.iconPathDay
                          : weather.weatherCode?.iconPathNight) ??
                      WeatherType.clearSkies.iconPathDay,
                ),
                width: 24.sp,
                height: 24.sp,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0).w,
            child: Text(
              '${weather.minTemp!}°',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Palette.shadowDark,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0).w,
            child: Text(
              '${weather.maxTemp!}°',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
