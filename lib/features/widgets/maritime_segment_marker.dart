import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/core/enumerate/enumerate.dart';
import 'package:reinmkg/utils/ext/double.dart';
import 'package:reinmkg/utils/helper/common.dart';
import '../../core/localization/l10n/generated/strings.dart';
import '../../domain/entities/weather/water_wave_entity.dart';
import '../cubit/general/settings/settings_cubit.dart';
import '../cubit/geojson/maritime_boundaries/maritime_boundaries_cubit.dart';
import 'geojson_parser.dart' as geojsonparser;

class MaritimeSegmentMarker extends StatefulWidget {
  const MaritimeSegmentMarker({
    super.key,
    required this.waterWaves,
  });

  final List<WaterWaveEntity> waterWaves;

  @override
  State<MaritimeSegmentMarker> createState() => _MaritimeSegmentMarkerState();
}

class _MaritimeSegmentMarkerState extends State<MaritimeSegmentMarker> {
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

  geojsonparser.GeoJsonParser geoJsonParser = geojsonparser.GeoJsonParser(
    defaultPolylineColor: Colors.white,
    defaultPolygonFillColor: Colors.white,
    defaultPolylineStroke: 2,
  );

  @override
  void initState() {
    super.initState();

    final boundariesCubit = BlocProvider.of<MaritimeBoundariesCubit>(context);

    if (boundariesCubit.state.boundaries == null) {
      if (boundariesCubit.state.status.isInitial ||
          boundariesCubit.state.status.isFailure) {
        boundariesCubit.getMaritimeBoundaries();
      }

      log.d('Boundaries not null');

      boundariesCubit.stream.listen((state) {
        if (state.boundaries != null) _drawPolygon(state.boundaries!);
        log.d(state.status.toString());
      });
    } else {
      log.d('Boundaries is not null');

      _drawPolygon(boundariesCubit.state.boundaries!);
    }
  }

  Future<void> processData(String geoJson) async {
    try {
      return geoJsonParser.parseGeoJsonAsString(geoJson);
    } catch (e) {
      log.d(e.toString());

      return;
    }
  }

  Polygon createDefaultPolygon(List<LatLng> outerRing,
      List<List<LatLng>>? holesList, Map<String, dynamic> properties) {
    final dataIndex = widget.waterWaves.indexWhere((e) {
      return properties['WP_1'].toString().endsWith(e.id!);
    });

    final wave = widget.waterWaves[dataIndex].today;

    final status = Strings.of(context).waveHeightStatus(wave?.name ?? '-');
    final isMetric =
        BlocProvider.of<SettingsCubit>(context).state.measurementUnit.isMetric;

    final heightMin =
        isMetric ? wave?.getWaveHeightMin : wave?.getWaveHeightMin.meterToFeet;
    final heightMax =
        isMetric ? wave?.getWaveHeightMax : wave?.getWaveHeightMax.meterToFeet;

    final unit = isMetric ? 'meter' : 'feet';

    final label =
        '$status\n${heightMin?.toStringAsFixed(1)} - ${heightMax?.toStringAsFixed(1)} $unit';

    return Polygon(
      points: outerRing,
      holePointsList: holesList,
      borderColor: Colors.black.withOpacity(0.8),
      color: wave == null ? null : waveColor[wave.index],
      label: wave == null ? '' : label,
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ) ??
          const TextStyle(),
      borderStrokeWidth: 1,
    );
  }

  Future<void> _drawPolygon(String boundaries) async {
    geoJsonParser.polygonCreationCallback = createDefaultPolygon;

    geoJsonParser.clearMarker();

    processData(boundaries).then((_) {
      if (!mounted) return;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return PolygonLayer(polygons: geoJsonParser.polygons);
  }
}
