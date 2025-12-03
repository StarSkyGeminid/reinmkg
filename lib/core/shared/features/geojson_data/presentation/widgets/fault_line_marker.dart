import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';

import '../cubit/fault_line_data/fault_line_data_cubit.dart';

class FaultLineMarker extends StatefulWidget {
  const FaultLineMarker({super.key});

  @override
  State<FaultLineMarker> createState() => _FaultLineMarkerState();
}

class _FaultLineMarkerState extends State<FaultLineMarker> {
  bool isRequested = false;
  GeoJsonParser geoJsonParser = GeoJsonParser(
    defaultPolylineColor: Colors.orange.withValues(alpha: 0.5),
    defaultPolylineStroke: 2,
  );
  StreamSubscription? _cubitSub;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _drawPolygon();
    });
  }

  void _drawPolygon() {
    final cubit = BlocProvider.of<FaultLineDataCubit>(context);
    if (cubit.state is FaultLineDataLoaded) {
      final polygon = (cubit.state as FaultLineDataLoaded).faultLine;
      _buildGeojson(polygon);
      return;
    }

    if ((cubit.state is FaultLineDataInitial ||
            cubit.state is FaultLineDataFailure) &&
        !isRequested) {
      cubit.getFaultLine();

      isRequested = true;
    }

    _cubitSub = cubit.stream.listen((state) {
      if (state is FaultLineDataLoaded) {
        _buildGeojson(state.faultLine);
      }
    });
  }

  Future<void> _buildGeojson(String faultLine) async {
    geoJsonParser.parseGeoJsonAsString(faultLine);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PolylineLayer(polylines: geoJsonParser.polylines);
  }

  @override
  void dispose() {
    _cubitSub?.cancel();
    super.dispose();
  }
}
