import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:reinmkg/utils/ext/ext.dart';

import '../../../../core/localization/l10n/generated/strings.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/widgets/notification_pulser.dart';
import '../../../../domain/entities/earthquake/earthquake_entity.dart';
import '../../../bloc/earthquake/selectable_earthquake/selectable_earthquake_bloc.dart';
import '../../../cubit/general/settings/settings_cubit.dart';

class EarthquakeBasicData extends StatefulWidget {
  const EarthquakeBasicData({super.key});

  @override
  State<EarthquakeBasicData> createState() => _EarthquakeBasicDataState();
}

class _EarthquakeBasicDataState extends State<EarthquakeBasicData> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectableEarthquakeBloc, SelectableEarthquakeState>(
      builder: (context, state) {
        final earthquake = state.earthquake;

        final warning = earthquake?.subject?.replaceFirst('Warning', '');

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0).w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _earthquakeMagnitude(earthquake, context),
                  if (warning != null)
                    _waringLabel(
                        warning: warning, tsunami: warning.contains('Tsunami')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0).w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _earthquakeInfo(
                    Symbols.schedule,
                    '${earthquake?.time?.toTimeString(second: false) ?? '-'} ${earthquake?.time?.toLocal().timeZoneName ?? ''}\n${earthquake?.time?.toDateLocalShort(context: context) ?? '-'}',
                    Strings.of(context).time,
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
      EarthquakeEntity? earthquake) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final isMetric = state.measurementUnit.isMetric;

        final depth =
            isMetric ? earthquake?.depth : earthquake?.depth?.kmToMiles;

        return _earthquakeInfo(
          Symbols.straighten,
          Strings.of(context).distanceWithUnit(
              isMetric.toString(), '${earthquake?.depth ?? 'nan'}', depth ?? 0),
          Strings.of(context).eqDepth,
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
            horizontal: 12.sp, vertical: (tsunami ? 6 : 4).sp),
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: tsunamiWarningEnd
                ? Theme.of(context).extension<AppColors>()!.teal
                : Theme.of(context).extension<AppColors>()!.maroon,
            borderRadius: BorderRadius.circular(8)),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 4.0.sp),
                  child: Icon(
                    tsunami
                        ? Symbols.tsunami_rounded
                        : Symbols.warning_amber_rounded,
                    color: tsunamiWarningEnd
                        ? Colors.green.shade900
                        : Colors.red.shade900,
                    size: 14.sp,
                  ),
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              TextSpan(
                text: Strings.of(context).eqWarning(warning),
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
          padding: EdgeInsets.only(left: 8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${earthquake?.magnitude?.toStringAsFixed(1) ?? '-'}SR',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(Strings.of(context).eqMagnitude,
                  style: Theme.of(context).textTheme.bodySmall),
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
        Icon(
          icon,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
