import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/core/shared/features/geojson_data/domain/enumerate/wave_height.dart';
import '../cubit/maritime_boundaries/maritime_boundaries_cubit.dart';
import '../models/maritime_wave_item.dart';
import 'package:reinmkg/features/general/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';

class MaritimeSegmentMarker extends StatefulWidget {
  const MaritimeSegmentMarker({
    super.key,
    required this.waterWaves,
    required this.onTap,
    this.selectedDay = 0,
  });

  final List<MaritimeWaveItem> waterWaves;

  final void Function(String) onTap;

  final int selectedDay;

  @override
  State<MaritimeSegmentMarker> createState() => _MaritimeSegmentMarkerState();
}

class _MaritimeSegmentMarkerState extends State<MaritimeSegmentMarker> {
  final LayerHitNotifier hitNotifier = ValueNotifier(null);

  List<Color> waveColor = [
    const Color(0x901EE45E),
    const Color(0x9085FC1B),
    const Color(0x90E0FF05),
    const Color(0x90FEE900),
    const Color(0x90FFB501),
    const Color(0x90FD6C01),
    const Color(0x90FB2000),
    const Color(0x90CB0001),
  ];

  GeoJsonParser geoJsonParser = GeoJsonParser(
    defaultPolylineColor: Colors.white,
    defaultPolygonFillColor: Colors.white,
    defaultPolylineStroke: 2,
  );

  @override
  void initState() {
    super.initState();
    final boundariesCubit = BlocProvider.of<MaritimeBoundariesCubit>(context);

    if (boundariesCubit.state.boundaries == null) {
      boundariesCubit.fetchMaritimeBoundaries();

      boundariesCubit.stream.listen((state) {
        if (state.boundaries != null) _drawPolygon(state.boundaries!);
      });
    } else {
      _drawPolygon(boundariesCubit.state.boundaries!);
    }

    handleTap();
  }

  @override
  void didUpdateWidget(covariant MaritimeSegmentMarker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedDay != widget.selectedDay) {
      final boundariesCubit = BlocProvider.of<MaritimeBoundariesCubit>(context);
      final boundaries = boundariesCubit.state.boundaries;

      if (boundaries != null) {
        _drawPolygon(boundaries);
      } else {
        setState(() {});
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void handleTap() {
    return hitNotifier.addListener(() {
      try {
        final hit = hitNotifier.value;
        if (hit == null || hit.hitValues.isEmpty) return;

        final properties = hit.hitValues[0];

        if (properties is! String) return;

        widget.onTap(properties);
      } catch (e) {
        return;
      }
    });
  }

  Future<void> processData(String geoJson) async {
    try {
      return geoJsonParser.parseGeoJsonAsString(geoJson);
    } catch (e) {
      return;
    }
  }

  Polygon createDefaultPolygon(
    List<LatLng> outerRing,
    List<List<LatLng>>? holesList,
    Map<String, dynamic> properties,
  ) {
    final dataIndex = widget.waterWaves.indexWhere((e) {
      final id = e.id ?? '';
      return properties['WP_1'].toString().endsWith(id);
    });

    final item = dataIndex >= 0 ? widget.waterWaves[dataIndex] : null;
    final wave = item != null
        ? (widget.selectedDay == 0
              ? item.today
              : (widget.selectedDay == 1 ? item.h2 : item.h3))
        : null;

    final status = wave != null
        ? '${wave.name[0].toUpperCase()}${wave.name.substring(1)}'
        : '-';

    final settingsState = BlocProvider.of<SettingsCubit>(context).state;
    final bool isMetric = settingsState is SettingsLoaded
        ? settingsState.isMetric
        : true;

    final heightMin = wave != null
        ? (isMetric ? wave.getWaveHeightMin : wave.getWaveHeightMin * 3.28084)
        : null;
    final heightMax = wave != null
        ? (isMetric ? wave.getWaveHeightMax : wave.getWaveHeightMax * 3.28084)
        : null;

    final unit = isMetric
        ? Strings.of(context).unitMeter
        : Strings.of(context).unitFeet;

    final label =
        '$status\n${heightMin?.toStringAsFixed(1)} - ${heightMax?.toStringAsFixed(1)} $unit';

    var wp1 = properties['WP_1'].toString();
    var wpimm = properties['WP_IMM'].toString();

    final hitValue = '${wp1}_$wpimm';

    return Polygon(
      points: outerRing,
      holePointsList: holesList,
      borderColor: Colors.black.withValues(alpha: 0.8),
      color: wave == null ? null : waveColor[wave.index],
      label: wave == null ? '' : label,
      labelStyle:
          Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold) ??
          const TextStyle(),
      borderStrokeWidth: 1,
      hitValue: hitValue,
    );
  }

  Future<void> _drawPolygon(String boundaries) async {
    geoJsonParser = GeoJsonParser(
      defaultPolylineColor: Colors.transparent,
      defaultPolygonFillColor: Colors.transparent,
      defaultPolylineStroke: 2,
    );

    geoJsonParser.polygonCreationCallback = createDefaultPolygon;

    processData(boundaries).then((_) {
      if (!mounted) return;

      setState(() {});
    });
  }

  @override
  void dispose() {
    hitNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PolygonLayer(
      hitNotifier: hitNotifier,
      polygons: geoJsonParser.polygons,
    );
  }
}
