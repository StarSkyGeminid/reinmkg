import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';
import 'package:reinmkg/features/earthquake/presentation/cubit/cubit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:reinmkg/core/shared/presentation/widgets/notification_pulser.dart';
import 'package:reinmkg/core/utils/extension/datetime.dart';
import 'package:reinmkg/core/utils/extension/double.dart';
import 'package:reinmkg/features/general/settings/presentation/cubit/settings_cubit.dart';

import '../../domain/entities/earthquake_entity.dart';

class EarthquakeBasicData extends StatefulWidget {
  const EarthquakeBasicData({super.key});

  @override
  State<EarthquakeBasicData> createState() => _EarthquakeBasicDataState();
}

class _EarthquakeBasicDataState extends State<EarthquakeBasicData> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectableEarthquakeCubit, SelectableEarthquakeState>(
      builder: (context, state) {
        final earthquake = state is SelectableEarthquakeSelected
            ? state.earthquake
            : null;

        final warning = earthquake?.subject?.replaceFirst('Warning', '');

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _earthquakeMagnitude(earthquake, context),
                  if (warning != null)
                    _waringLabel(
                      warning: warning,
                      tsunami: warning.contains('Tsunami'),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _earthquakeInfo(
                    Symbols.schedule,
                    '${earthquake?.time?.toTimeString(second: false) ?? '-'} ${earthquake?.time?.toLocal().timeZoneName ?? ''}\n${earthquake?.time?.toDateLocalShort(context: context) ?? '-'}',
                    Strings.of(context).earthquakeTime,
                  ),
                  _earthquakeDepth(earthquake),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  BlocBuilder<SettingsCubit, SettingsState> _earthquakeDepth(
    EarthquakeEntity? earthquake,
  ) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final isMetric = (state is SettingsLoaded) ? state.isMetric : true;

        final depth = isMetric
            ? earthquake?.depth
            : earthquake?.depth?.kmToMiles;

        return _earthquakeInfo(
          Symbols.straighten,
          '${depth?.round() ?? '-'} ${isMetric ? Strings.of(context).unitKm : Strings.of(context).unitMiles}',
          Strings.of(context).earthquakeDepth,
        );
      },
    );
  }

  Widget _waringLabel({String? warning, bool tsunami = false}) {
    bool tsunamiWarningEnd = warning?.contains('PD-4') ?? false;

    warning = _getWarning(warning);

    return NotificationPulser(
      duration: const Duration(milliseconds: 500),
      begin: 0.7,
      end: 1.0,
      background: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: (tsunami ? 6 : 4),
        ),
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: tsunamiWarningEnd ? Color(0xff94e2d5) : Color(0xfff38ba8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(
                    tsunami
                        ? Symbols.tsunami_rounded
                        : Symbols.warning_amber_rounded,
                    color: tsunamiWarningEnd
                        ? Colors.green.shade900
                        : Colors.red.shade900,
                    size: 14,
                  ),
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              TextSpan(
                text: _localizedWarningLabel(context, warning),
                style: TextStyle(
                  color: tsunamiWarningEnd
                      ? Colors.green.shade900
                      : Colors.red.shade900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getWarning(String? warning) {
    if (warning!.toLowerCase().contains('gempa dirasakan')) {
      return 'felt';
    } else if (warning.toLowerCase().contains('m>5')) {
      return 'mover5';
    } else if (warning.contains('PD-1')) {
      return 'pd1';
    } else if (warning.contains('PD-2')) {
      return 'pd3';
    } else if (warning.contains('PD-3')) {
      return 'pd3';
    } else if (warning.contains('PD-4')) {
      return 'pd4';
    }
    return 'Realtime';
  }

  String _localizedWarningLabel(BuildContext context, String? warning) {
    if (warning == null) return '';

    final w = warning.toLowerCase();

    if (w == 'felt') return Strings.of(context).eqType('felt');
    if (w == 'mover5' || w.contains('m>5') || w.contains('over5')) {
      return Strings.of(context).eqType('overFive');
    }
    if (w == 'realtime' || w == 'realtime') {
      return Strings.of(context).eqType('realtime');
    }

    if (w.startsWith('pd')) {
      final number = w.replaceFirst('pd', '');
      return 'PD-${number.toUpperCase()}';
    }

    return warning;
  }

  Row _earthquakeMagnitude(EarthquakeEntity? earthquake, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          QWeatherIcons.tag_earthquake_warning.iconData,
          size: Theme.of(context).textTheme.headlineMedium?.fontSize ?? 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${earthquake?.magnitude?.toStringAsFixed(1) ?? '-'} ${Strings.of(context).magnitudeUnit}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                Strings.of(context).earthquakeMagnitude,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _earthquakeInfo(IconData icon, String value, String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(title, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
