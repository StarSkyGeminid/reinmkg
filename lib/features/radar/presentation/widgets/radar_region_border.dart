import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/core/shared/features/geojson_data/presentation/cubit/region_border_overlay/region_border_overlay_cubit.dart';

import '../cubit/cubit.dart';

class RadarRegionBorder extends StatefulWidget {
  const RadarRegionBorder({super.key});

  @override
  State<RadarRegionBorder> createState() => _RadarRegionBorderState();
}

class _RadarRegionBorderState extends State<RadarRegionBorder> {
  StreamSubscription? _borderSub;
  StreamSubscription? _radarSub;

  GeoJsonParser _geoJsonParser = GeoJsonParser(
    defaultPolylineColor: Colors.white,
    defaultPolygonFillColor: Colors.transparent,
    defaultPolylineStroke: 2,
  );

  Map<String, dynamic>? _border;
  LatLng? _circleCenter;
  double? _circleRadiusMeters;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  void _init() {
    final borderCubit = BlocProvider.of<RegionBorderOverlayCubit>(context);
    final radarCubit = BlocProvider.of<RadarSelectionCubit>(context);

    _border = borderCubit.state.border;
    _updateRadar(radarCubit.state);

    _borderSub = borderCubit.stream.listen((state) {
      _border = state.border;
      _maybeDraw();
    });

    _radarSub = radarCubit.stream.listen((state) {
      _updateRadar(state);
      _maybeDraw();
    });

    if (_border == null) {
      borderCubit.getRegionBorder();
    }

    _maybeDraw();
  }

  void _updateRadar(RadarSelectionState state) {
    if (state is RadarSelectionLoaded) {
      final tlc = state.radar.tlc;
      final brc = state.radar.brc;
      _circleCenter = state.radar.position;
      if (tlc != null && brc != null) {
        const Distance distance = Distance();
        _circleRadiusMeters =
            distance.as(LengthUnit.Meter, tlc, LatLng(brc.latitude, tlc.longitude)) /
                2;
      }
    }
  }

  void _maybeDraw() {
    if (_border == null || _circleCenter == null || _circleRadiusMeters == null) {
      return;
    }
    if (!mounted) return;

    _geoJsonParser = GeoJsonParser(
      defaultPolylineColor: Colors.white,
      defaultPolygonFillColor: Colors.transparent,
      defaultPolylineStroke: 2,
    );

    _geoJsonParser.polygonCreationCallback =
        (outerRing, holesList, properties) {
      return Polygon(
        points: outerRing,
        holePointsList: holesList,
        borderColor: Colors.white,
        color: const Color.fromARGB(0, 5, 3, 3),
        borderStrokeWidth: 1,
      );
    };

    try {
      _geoJsonParser.parseGeoJson(_border!);
    } catch (_) {
      return;
    }

    final center = _circleCenter!;
    final radius = _circleRadiusMeters!;
    const Distance distance = Distance();

    _geoJsonParser.polygons.removeWhere((polygon) {
      return !polygon.points.any((point) {
        return distance.as(LengthUnit.Meter, center, point) <= radius;
      });
    });

    setState(() {});
  }

  @override
  void dispose() {
    _borderSub?.cancel();
    _radarSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PolygonLayer(polygons: _geoJsonParser.polygons);
  }
}
