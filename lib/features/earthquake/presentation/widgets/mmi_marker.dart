import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:latlong2/latlong.dart';
import 'package:numerus/numerus.dart';
import 'package:reinmkg/core/shared/features/geojson_data/presentation/cubit/cubit.dart';

import '../../domain/entities/earthquake_mmi_entity.dart';
import '../cubit/selectable_earthquake/selectable_earthquake_cubit.dart';

class MMIMarker extends StatefulWidget {
  const MMIMarker({super.key});

  @override
  State<MMIMarker> createState() => _MMIMarkerState();
}

class _MMIMarkerState extends State<MMIMarker> {
  List<EarthquakeMmiEntity> listEarthquakeMMI = [];
  String regionsRegex = '';

  List<Color> mmiColor = [
    const Color(0xFF0028DD),
    const Color(0xFF007ACC),
    const Color(0xFF11CA57),
    const Color(0xFF81E31D),
    const Color(0xFFE7ED0A),
    const Color(0xFFFEDF0A),
    const Color(0xFFFEAF0A),
    const Color(0xFFFF6F08),
    const Color(0xFFFF3009),
    const Color(0xFFDD1304),
  ];

  GeoJsonParser geoJsonParser = GeoJsonParser(
    defaultPolylineColor: Colors.white,
    defaultPolygonFillColor: Colors.white,
    defaultPolylineStroke: 2,
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provinceBorderCubit = BlocProvider.of<RegionBorderOverlayCubit>(
        context,
      );

      BlocProvider.of<SelectableEarthquakeCubit>(context).startListening();

      if (provinceBorderCubit.state.border == null) {
        provinceBorderCubit.getRegionBorder();

        BlocProvider.of<RegionBorderOverlayCubit>(context).stream.listen((
          state,
        ) {
          if (state.border != null) _drawPolygon(state.border!);
        });
      } else {
        _drawPolygon(provinceBorderCubit.state.border!);
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

  bool filterRegion(Map<String, dynamic> properties) {
    final district = properties['WADMKK'].toString().toUpperCase().contains(
      RegExp('($regionsRegex)'),
    );
    final province = properties['WADMPR'].toString().toUpperCase().contains(
      RegExp('($regionsRegex)'),
    );

    return district || province;
  }

  Polygon createDefaultPolygon(
    List<LatLng> outerRing,
    List<List<LatLng>>? holesList,
    Map<String, dynamic> properties,
  ) {
    final dataIndex = listEarthquakeMMI.indexWhere((e) {
      final district = properties['WADMKK'].toString().toUpperCase().endsWith(
        e.district!.toUpperCase(),
      );

      final province = properties['WADMPR'].toString().toUpperCase().endsWith(
        e.district!.toUpperCase(),
      );

      return district || province;
    });

    final mmi = listEarthquakeMMI[dataIndex].mmiMin;

    return Polygon(
      points: outerRing,
      holePointsList: holesList,
      borderColor: Colors.black.withValues(alpha: 0.8),
      color: mmi == null
          ? null
          : mmiColor[mmi > 7
                ? 7
                : mmi < 0
                ? 0
                : mmi],
      label: mmi == null ? '' : '${mmi.toRomanNumeralString()} MMI',
      labelStyle:
          Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold) ??
          const TextStyle(),
      borderStrokeWidth: 1,
    );
  }

  Future<void> _drawPolygon(String provinceBorder) async {
    BlocProvider.of<SelectableEarthquakeCubit>(context).stream.listen((state) {
      if (state is! SelectableEarthquakeSelected) return;

      final earthquake = state.earthquake;

      listEarthquakeMMI = earthquake.earthquakeMMI ?? [];

      geoJsonParser = GeoJsonParser(
        defaultPolylineColor: Colors.transparent,
        defaultPolygonFillColor: Colors.transparent,
        defaultPolylineStroke: 2,
      );

      geoJsonParser.filterFunction = filterRegion;

      geoJsonParser.polygonCreationCallback = createDefaultPolygon;

      if (!mounted) return;

      if (listEarthquakeMMI.isEmpty) {
        setState(() {});
        return;
      }

      regionsRegex = listEarthquakeMMI
          .map((e) => e.district?.toUpperCase())
          .join('|');

      regionsRegex = '($regionsRegex)\$';

      processData(provinceBorder).then((_) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PolygonLayer(polygons: geoJsonParser.polygons);
  }
}
