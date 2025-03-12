import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:reinmkg/utils/ext/ext.dart';

import '../../../../core/localization/l10n/generated/strings.dart';
import '../../../../core/resources/palette.dart';
import '../../../../domain/entities/earthquake/earthquake_entity.dart';
import '../../../cubit/general/settings/settings_cubit.dart';

class EarthquakeData extends StatefulWidget {
  const EarthquakeData({super.key, required this.earthquake});

  final EarthquakeEntity? earthquake;

  @override
  State<EarthquakeData> createState() => _EarthquakeDataState();
}

class _EarthquakeDataState extends State<EarthquakeData> {
  @override
  Widget build(BuildContext context) {
    return _earthquakeData(widget.earthquake);
  }

  Widget _earthquakeData(EarthquakeEntity? earthquake) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _earthquakeInfo(
            QWeatherIcons.tag_earthquake_warning.iconData,
            '${earthquake?.magnitude?.toStringAsFixed(1) ?? '-'}SR',
            Strings.of(context).eqMagnitude,
          ),
          _depth(earthquake),
          _earthquakeInfo(
            Symbols.schedule,
            '${earthquake?.time?.toTimeString(second: false) ?? ''} ${earthquake?.time?.toLocal().timeZoneName ?? ''}\n${earthquake?.time?.toDateLocalShort(context: context) ?? '-'}',
            Strings.of(context).time,
          ),
        ],
      ),
    );
  }

  BlocBuilder<SettingsCubit, SettingsState> _depth(
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

  Widget _earthquakeInfo(IconData icon, String value, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.sp),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Palette.subText,
              ),
        ),
      ],
    );
  }
}
