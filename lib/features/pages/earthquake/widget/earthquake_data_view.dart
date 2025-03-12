import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/features/features.dart';

import '../../../../dependencies_injection.dart';
import 'earthquake_history_list.dart';

class EarthquakeDataView extends StatefulWidget {
  const EarthquakeDataView(
      {super.key, required this.earthquakesType, required this.onTap});

  final EarthquakesType earthquakesType;
  final VoidCallback onTap;

  @override
  State<EarthquakeDataView> createState() => _EarthquakeDataViewState();
}

class _EarthquakeDataViewState extends State<EarthquakeDataView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EarthquakeHistoryByTypeCubit>(
      create: (context) => sl(),
      child: EarthquakeHistoryList(
        earthquakesType: widget.earthquakesType,
        onTap: widget.onTap,
      ),
    );
  }
}
