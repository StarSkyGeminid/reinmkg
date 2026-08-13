import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/features/celestial/domain/entities/celestial_entity.dart';
import 'package:reinmkg/features/celestial/domain/entities/celestial_object_entity.dart';
import 'package:reinmkg/features/celestial/presentation/cubit/celestial_cubit.dart';
import 'package:reinmkg/features/general/location/domain/entities/location_entity.dart';
import 'package:reinmkg/features/general/location/presentation/cubit/location_cubit.dart';

import 'celestial_card.dart';
import 'moon_phase.dart';
import '../../../../core/localization/l10n/generated/strings.dart';
import '../../../../core/utils/extension/datetime.dart';

class CelestialData extends StatefulWidget {
  const CelestialData({super.key});

  @override
  State<CelestialData> createState() => _CelestialDataState();
}

class _CelestialDataState extends State<CelestialData> {
  CelestialEntity? celestial;

  @override
  void initState() {
    super.initState();

    final state = BlocProvider.of<LocationCubit>(context).state;

    if (state is! LocationLoaded) {
      return;
    }

    LocationEntity? location = state.location;

    if (location.latitude == null || location.longitude == null) {
      return;
    }

    BlocProvider.of<CelestialCubit>(context).stream.listen((state) {
      if (state is CelestialLoaded) {
        celestial = state.celestialData;

        _refreshState();
      }
    });

    BlocProvider.of<CelestialCubit>(
      context,
    ).getCelestialdata(DateTime.now(), location.latitude!, location.longitude!);
  }

  void _refreshState() {
    if (celestial?.sun != null && celestial?.moon != null) {
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
          height: 0.2,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.01),
            borderRadius: BorderRadius.circular(20),
          ),
          child: AnimatedCelestialPathGraph(
            currentTime: DateTime.now(),
            celestial: celestial,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildSunCard(celestial?.sun),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              _buildMoonCard(celestial?.moon),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              if (celestial?.moon?.fraction != null &&
                  celestial?.moon?.phase != null)
                MoonPhaseWidget(
                  fraction: celestial!.moon!.fraction!,
                  phase: celestial!.moon!.phase!,
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSunCard(CelestialObjectEntity? entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            children: [
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Symbols.sunny, color: Colors.orange),
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              TextSpan(text: Strings.of(context).sunLabel),
            ],
          ),
        ),
        const Divider(),
        const SizedBox(height: 4),
        _buildTimeInfo(Strings.of(context).sunriseLabel, entity?.riseTime,
            alwaysUp: entity?.alwaysUp, alwaysDown: entity?.alwaysDown),
        _buildTimeInfo(Strings.of(context).solarNoonLabel, entity?.solarNoon),
        _buildTimeInfo(Strings.of(context).sunsetLabel, entity?.setTime,
            alwaysUp: entity?.alwaysUp, alwaysDown: entity?.alwaysDown),
        _buildTimeInfo(Strings.of(context).dawnLabel, entity?.dawn),
        _buildTimeInfo(Strings.of(context).duskLabel, entity?.dusk),
        _buildTimeInfo(Strings.of(context).goldenHourLabel, entity?.goldenHour),
      ],
    );
  }

  Widget _buildMoonCard(CelestialObjectEntity? entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            children: [
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Symbols.nightlight, color: Colors.blueGrey),
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              TextSpan(text: Strings.of(context).moonLabel),
            ],
          ),
        ),
        const Divider(),
        const SizedBox(height: 4),
        _buildTimeInfo(Strings.of(context).moonriseLabel, entity?.riseTime,
            alwaysUp: entity?.alwaysUp, alwaysDown: entity?.alwaysDown),
        _buildTimeInfo(Strings.of(context).moonsetLabel, entity?.setTime,
            alwaysUp: entity?.alwaysUp, alwaysDown: entity?.alwaysDown),
        if (entity?.distance != null)
          _buildDetailRow(
            Strings.of(context).moonDistanceLabel,
            '${NumberFormat('#,###').format(entity!.distance!.round())} km',
          ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildTimeInfo(String label, DateTime? time,
      {bool? alwaysUp, bool? alwaysDown}) {
    String displayText;
    if (time != null) {
      displayText = time.toTimeString(second: false, withTimezone: true);
    } else if (alwaysUp == true) {
      displayText = Strings.of(context).alwaysUpLabel;
    } else if (alwaysDown == true) {
      displayText = Strings.of(context).alwaysDownLabel;
    } else {
      displayText = Strings.of(context).notAvailableLabel;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(displayText),
        ],
      ),
    );
  }
}
