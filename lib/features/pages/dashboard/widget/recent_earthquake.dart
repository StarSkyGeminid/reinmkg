import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';

import '../../../../core/localization/l10n/generated/strings.dart';
import '../../../../domain/entities/earthquake/earthquake_entity.dart';
import '../../../bloc/earthquake/recent_earthquake/recent_earthquake_bloc.dart';
import 'earthquake_card.dart';

class RecentEarthquake extends StatefulWidget {
  const RecentEarthquake({super.key});

  @override
  State<RecentEarthquake> createState() => _RecentEarthquakeState();
}

class _RecentEarthquakeState extends State<RecentEarthquake>
    with SingleTickerProviderStateMixin {
  final BehaviorSubject<EarthquakeEntity> streamEarthquake =
      BehaviorSubject<EarthquakeEntity>();

  @override
  void initState() {
    BlocProvider.of<RecentEarthquakeBloc>(context).stream.listen((state) {
      if (state.status.isSuccess && state.earthquake != null) {
        streamEarthquake.add(state.earthquake!);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EarthquakeCard(
      title: Strings.of(context).eqRealtime,
      earthquakeStream: streamEarthquake.asBroadcastStream(),
    );
  }
}
