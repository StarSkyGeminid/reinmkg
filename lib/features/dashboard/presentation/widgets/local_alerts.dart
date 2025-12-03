import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/core/dependencies_injection.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';
import 'package:reinmkg/core/router.dart';
import 'package:reinmkg/features/earthquake/domain/entities/earthquake_entity.dart';
import 'package:reinmkg/features/earthquake/presentation/cubit/earthquake/earthquake_cubit.dart';
import 'package:reinmkg/features/earthquake/presentation/cubit/selectable_earthquake/selectable_earthquake_cubit.dart';
import 'package:reinmkg/features/general/location/domain/entities/location_entity.dart';
import 'package:reinmkg/features/general/location/presentation/cubit/location_cubit.dart';
import 'package:reinmkg/features/nowcast/domain/entities/weather_nowcast_entity.dart';
import 'package:reinmkg/features/nowcast/presentation/cubit/nowcast_cubit.dart';

class LocalAlertsWidget extends StatelessWidget {
  const LocalAlertsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LocationCubit, LocationState, dynamic>(
      selector: (s) => s is LocationLoaded ? s.location : null,
      builder: (context, location) {
        if (location == null) return const SizedBox.shrink();

        return BlocBuilder<EarthquakeCubit, EarthquakeState>(
          builder: (context, eqState) {
            EarthquakeEntity? eq;
            if (eqState is EarthquakeLoaded) eq = eqState.earthquake;

            if (eq != null && eq.felt != null) {
              final alert = _earthquakeAlert(context, eq, location);

              if (alert != null) return alert;
            }

            return BlocBuilder<NowcastCubit, NowcastState>(
              builder: (context, nowState) {
                if (nowState is NowcastLoaded) {
                  final alert = _weatherAlert(
                    context,
                    nowState.nowcasts,
                    location,
                  );

                  if (alert != null) return alert;
                }

                return const SizedBox.shrink();
              },
            );
          },
        );
      },
    );
  }

  Widget? _earthquakeAlert(
    BuildContext context,
    EarthquakeEntity eq,
    LocationEntity location,
  ) {
    final feltText = eq.felt!.toLowerCase();
    final reg = (location.regency ?? '')
        .toLowerCase()
        .replaceAll('kota', '')
        .trim();

    if (reg.isNotEmpty && feltText.contains(reg)) {
      final title = Strings.of(
        context,
      ).earthquakeFeltInRegency(location.regency ?? '');
      final subtitle = eq.magnitude != null
          ? '${eq.magnitude} ${Strings.of(context).magnitudeUnit}'
          : eq.area ?? '';

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.06),
          child: ListTile(
            leading: Icon(
              Symbols.notification_important,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(subtitle),
            onTap: () {
              final cubit = sl<SelectableEarthquakeCubit>();
              cubit.setSelected(eq);

              return context.go(Routes.earthquake.path);
            },
          ),
        ),
      );
    }

    return null;
  }

  Widget? _weatherAlert(
    BuildContext context,
    List<WeatherNowcastEntity> nowcasts,
    LocationEntity location,
  ) {
    final reg = (location.regency ?? '')
        .toLowerCase()
        .replaceAll('kota', '')
        .trim();

    for (final now in nowcasts) {
      final affected = now.affectedDistricts ?? [];
      affected.addAll(now.spreadDistricts ?? []);

      final matches = affected.any((d) {
        final name = (d.name ?? '').toLowerCase();
        return (reg.isNotEmpty && name.contains(reg));
      });

      if (!matches) continue;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          color: Theme.of(
            context,
          ).colorScheme.secondary.withValues(alpha: 0.06),
          child: ListTile(
            leading: Icon(
              Symbols.warning,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              Strings.of(
                context,
              ).weatherAlertIssuedForRegency(location.regency ?? ''),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${now.headline} (${location.regency})'),
            onTap: () {
              context.pushNamed(Routes.nowcast.name, extra: now);
            },
          ),
        ),
      );
    }

    return null;
  }
}
