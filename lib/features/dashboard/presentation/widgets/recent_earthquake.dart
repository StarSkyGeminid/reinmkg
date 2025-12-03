import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reinmkg/features/earthquake/domain/entities/earthquake_entity.dart';
import 'package:reinmkg/core/dependencies_injection.dart';
import 'package:reinmkg/features/earthquake/presentation/cubit/cubit.dart';

import 'earthquake_card.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';

class RecentEarthquake extends StatefulWidget {
  const RecentEarthquake({super.key});

  @override
  State<RecentEarthquake> createState() => _RecentEarthquakeState();
}

class _RecentEarthquakeState extends State<RecentEarthquake>
    with SingleTickerProviderStateMixin {
  final StreamController<EarthquakeEntity> streamEarthquake =
      StreamController<EarthquakeEntity>.broadcast();

  EarthquakeCubit? _cubit;
  StreamSubscription<EarthquakeEntity>? _sub;

  @override
  void initState() {
    super.initState();

    _cubit = sl<EarthquakeCubit>();
    _cubit?.startListening();
    _cubit?.getRecentEarthquake();

    _sub = _cubit?.recentEarthquakeStream.listen(
      (event) => streamEarthquake.add(event),
      onError: (err) => streamEarthquake.addError(err),
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    streamEarthquake.close();
    _cubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit!,
      child: EarthquakeCard(
        title: Strings.of(context).earthquakeRealtime,
        earthquakeStream: streamEarthquake.stream,
      ),
    );
  }
}
