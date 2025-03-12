import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/features/cubit/cubit.dart';

import '../../../../core/localization/l10n/generated/strings.dart';
import '../../../../domain/entities/celestial/celestial_entity.dart';
import '../../../../domain/entities/location/location_entity.dart';
import 'celestial_card.dart';
import 'moon_phase.dart';

class CelestialData extends StatefulWidget {
  const CelestialData({super.key});

  @override
  State<CelestialData> createState() => _CelestialDataState();
}

class _CelestialDataState extends State<CelestialData> {
  CelestialEntity? _sunEntity;
  CelestialEntity? _moonEntity;

  @override
  void initState() {
    super.initState();

    LocationEntity? location =
        BlocProvider.of<LocationCubit>(context).state.location;

    if (location == null) return;

    location = LocationEntity(
      latitude: location.latitude,
      longitude: location.longitude,
      time: DateTime.now().subtract(const Duration(days: 8)),
    );

    BlocProvider.of<SunPositionCubit>(context).stream.listen((state) {
      if (state.status.isSuccess && state.position != null) {
        _sunEntity = state.position;

        _refreshState();
      }
    });

    BlocProvider.of<MoonPositionCubit>(context).stream.listen((state) {
      if (state.status.isSuccess && state.position != null) {
        _moonEntity = state.position;
        _refreshState();
      }
    });

    BlocProvider.of<MoonPositionCubit>(context).getMoonData(location);
    BlocProvider.of<SunPositionCubit>(context).getSunData(location);
  }

  void _refreshState() {
    if (_sunEntity != null && _moonEntity != null) {
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 200, maxHeight: 300),
          height: 0.2.sh,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.01),
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: AnimatedCelestialPathGraph(
            currentTime: DateTime.now(),
            sun: _sunEntity,
            moon: _moonEntity,
          ),
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              _buildSunCard(_sunEntity),
              SizedBox(height: 8.h),
              _buildMoonCard(_moonEntity),
              SizedBox(height: 16.h),
              if (_moonEntity?.illumination != null &&
                  _moonEntity?.phaseAngle != null)
                MoonPhaseWidget(
                  fraction: _moonEntity!.illumination!,
                  phase: _moonEntity!.phaseAngle!,
                ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSunCard(CelestialEntity? entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0).w,
                  child: const Icon(Symbols.sunny, color: Colors.orange),
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              TextSpan(
                text: Strings.of(context).sunText,
              ),
            ],
          ),
        ),
        // const SizedBox(height: 4),
        const Divider(),
        SizedBox(height: 4.h),
        _buildTimeInfo(Strings.of(context).sunriseText, entity?.riseTime),
        _buildTimeInfo(Strings.of(context).sunsetText, entity?.setTime),
      ],
    );
  }

  Widget _buildMoonCard(CelestialEntity? entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0).w,
                  child: const Icon(Symbols.dark_mode, color: Colors.blueGrey),
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              TextSpan(
                text: Strings.of(context).moonText,
              ),
            ],
          ),
        ),
        const Divider(),
        SizedBox(height: 4.h),
        _buildTimeInfo(Strings.of(context).moonriseText, entity?.riseTime),
        _buildTimeInfo(Strings.of(context).moonsetText, entity?.setTime),
      ],
    );
  }

  Widget _buildTimeInfo(String label, DateTime? time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(time != null
              ? DateFormat('HH:mm').format(time)
              : 'Not available'),
        ],
      ),
    );
  }
}
