import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:numerus/numerus.dart';

import '../../domain/entities/earthquake/earthquake_mmi_entity.dart';
import '../../utils/helper/common.dart';
import '../bloc/earthquake/selectable_earthquake/selectable_earthquake_bloc.dart';
import '../cubit/geojson/region_border/region_border_cubit.dart';
import 'geojson_parser.dart' as geojsonparser;

class MMIMarker extends StatefulWidget {
  const MMIMarker({super.key});

  @override
  State<MMIMarker> createState() => _MMIMarkerState();
}

class _MMIMarkerState extends State<MMIMarker> {
  List<EarthquakeMmiEntity> listEarthquakeMMI = [];
  String regionsRegex = '';

  List<Color> mmiColor = [
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provinceBorderCubit = BlocProvider.of<RegionBorderCubit>(context);

      BlocProvider.of<SelectableEarthquakeBloc>(context)
          .add(const SelectableEarthquakeEvent.started());

      if (provinceBorderCubit.state.provinceBorder == null) {
        provinceBorderCubit.getRegionBorder();

        BlocProvider.of<RegionBorderCubit>(context).stream.listen((state) {
          if (state.provinceBorder != null) _drawPolygon(state.provinceBorder!);
        });
      } else {
        _drawPolygon(provinceBorderCubit.state.provinceBorder!);
      }
    });
  }

  Future<void> processData(String geoJson) async {
    try {
      return geoJsonParser.parseGeoJsonAsString(geoJson);
    } catch (e) {
      log.d(e.toString());
      return;
    }
  }

  bool filterRegion(Map<String, dynamic> properties) {
    final district =
        properties['alt_name'].toString().contains(RegExp('($regionsRegex)'));
    final province =
        properties['prov_name'].toString().contains(RegExp('($regionsRegex)'));

    return district || province;
  }

  Polygon createDefaultPolygon(List<LatLng> outerRing,
      List<List<LatLng>>? holesList, Map<String, dynamic> properties) {
    final dataIndex = listEarthquakeMMI.indexWhere((e) {
      final district = properties['alt_name']
          .toString()
          .endsWith(e.district!.toUpperCase().replaceAll('KAB.', 'KABUPATEN'));

      final province = properties['prov_name']
          .toString()
          .endsWith(e.district!.toUpperCase());

      return district || province;
    });

    final mmi = listEarthquakeMMI[dataIndex].mmiMin;

    return Polygon(
      points: outerRing,
      holePointsList: holesList,
      borderColor: Colors.black.withOpacity(0.8),
      color: mmi == null
          ? null
          : mmiColor[mmi > 7
              ? 7
              : mmi < 0
                  ? 0
                  : mmi],
      label: mmi == null ? '' : '${mmi.toRomanNumeralString()} MMI',
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ) ??
          const TextStyle(),
      borderStrokeWidth: 1,
    );
  }

  Future<void> _drawPolygon(String provinceBorder) async {
    geoJsonParser.filterFunction = filterRegion;

    geoJsonParser.polygonCreationCallback = createDefaultPolygon;

    BlocProvider.of<SelectableEarthquakeBloc>(context).stream.listen((state) {
      listEarthquakeMMI = state.earthquake?.earthquakeMMI ?? [];

      geoJsonParser.clearMarker();

      if (!mounted) return;

      if (listEarthquakeMMI.isEmpty) {
        setState(() {});
        return;
      }

      regionsRegex = listEarthquakeMMI
          .map((e) => e.district?.toUpperCase().replaceAll('KAB.', 'KABUPATEN'))
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
