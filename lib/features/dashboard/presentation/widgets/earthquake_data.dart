import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:reinmkg/core/utils/extension/datetime.dart';
import 'package:reinmkg/core/utils/extension/num_extension.dart';
import 'package:reinmkg/features/earthquake/domain/entities/earthquake_entity.dart';
import 'package:reinmkg/features/general/settings/presentation/cubit/settings_cubit.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _earthquakeInfo(
            QWeatherIcons.tag_earthquake_warning.iconData,
            '${earthquake?.magnitude?.toStringAsFixed(0) ?? '-'} ${Strings.of(context).magnitudeUnit}',
            Strings.of(context).earthquakeMagnitude,
          ),
          _depth(earthquake),
          _earthquakeInfo(
            Symbols.schedule,
            '${earthquake?.time?.toTimeString(second: false) ?? ''} ${earthquake?.time?.toLocal().timeZoneName ?? ''}\n${earthquake?.time?.toDateLocalShort(context: context) ?? '-'}',
            Strings.of(context).earthquakeTime,
          ),
        ],
      ),
    );
  }

  BlocBuilder<SettingsCubit, SettingsState> _depth(
    EarthquakeEntity? earthquake,
  ) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final isMetric = state is SettingsLoaded ? state.isMetric : true;

        final depth = isMetric
            ? earthquake?.depth
            : earthquake?.depth?.kilometersToMiles;

        final unit = isMetric
            ? Strings.of(context).unitKm
            : Strings.of(context).unitMiles;
        final depthValue = depth != null
            ? (isMetric ? depth : depth).round().toString()
            : '-';

        return _earthquakeInfo(
          Symbols.straighten,
          '$depthValue $unit',
          Strings.of(context).earthquakeDepth,
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
            Icon(icon),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
