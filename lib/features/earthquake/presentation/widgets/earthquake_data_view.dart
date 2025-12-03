import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reinmkg/core/dependencies_injection.dart';

import '../../domain/enumerates/earthquakes_type.dart';
import '../cubit/earthquake_history_by_type/earthquake_history_by_type_cubit.dart';
import 'earthquake_history_list.dart';

class EarthquakeDataView extends StatefulWidget {
  const EarthquakeDataView({
    super.key,
    required this.earthquakesType,
    required this.onTap,
  }) ;

  final EarthquakesType earthquakesType;
  final VoidCallback onTap;

  @override
  State<EarthquakeDataView> createState() => _EarthquakeDataViewState();
}

class _EarthquakeDataViewState extends State<EarthquakeDataView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EarthquakeHistoryByTypeCubit>(
      create: (context) => EarthquakeHistoryByTypeCubit(sl()),
      child: EarthquakeHistoryList(
        earthquakesType: widget.earthquakesType,
        onTap: widget.onTap,
      ),
    );
  }
}
