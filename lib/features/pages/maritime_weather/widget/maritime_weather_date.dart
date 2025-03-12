import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/l10n/generated/strings.dart';
import '../../../cubit/weather/water_wave/water_wave_cubit.dart';

class MaritimeWeatherDate extends StatelessWidget {
  const MaritimeWeatherDate({super.key});

  @override
  Widget build(BuildContext context) {
    return _dateTimeView();
  }

  BlocBuilder<WaterWaveCubit, WaterWaveState> _dateTimeView() {
    return BlocBuilder<WaterWaveCubit, WaterWaveState>(
      builder: (context, state) {
        if (!state.status.isSuccess) {
          return const SizedBox.shrink();
        }

        final time = state.waves?[0].time;

        if (time == null) return const SizedBox.shrink();

        final dateString =
            DateFormat('dd-MM-yyyy HH:mm', Strings.of(context).localeName)
                .format(time.toLocal());

        return Container(
          margin: const EdgeInsets.only(top: 4).h,
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          child: Text(dateString),
        );
      },
    );
  }
}
