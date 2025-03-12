import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';

import '../../../../core/localization/l10n/generated/strings.dart';
import '../../../../domain/entities/earthquake/earthquake_entity.dart';
import '../../../bloc/earthquake/last_earthquake_felt/last_earthquake_felt_bloc.dart';
import 'earthquake_card.dart';

class LastEarthquakeFelt extends StatefulWidget {
  const LastEarthquakeFelt({super.key});

  @override
  State<LastEarthquakeFelt> createState() => _LastEarthquakeFeltState();
}

class _LastEarthquakeFeltState extends State<LastEarthquakeFelt>
    with SingleTickerProviderStateMixin {
  final BehaviorSubject<EarthquakeEntity> streamEarthquake =
      BehaviorSubject<EarthquakeEntity>();

  @override
  void initState() {
    BlocProvider.of<LastEarthquakeFeltBloc>(context).stream.listen((state) {
      if (state.status.isSuccess && state.earthquake != null) {
        streamEarthquake.add(state.earthquake!);
      } else if (state.status.isFailure) {
        streamEarthquake.addError(state.message!);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EarthquakeCard(
      title: Strings.of(context).eqFelt,
      earthquakeStream: streamEarthquake.asBroadcastStream(),
    );
  }
}
