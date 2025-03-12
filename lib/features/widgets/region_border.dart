import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/utils/helper/common.dart';

import '../cubit/geojson/region_border/region_border_cubit.dart';
import 'geojson_parser.dart' as geojsonparser;

class RegionBorder extends StatefulWidget {
  const RegionBorder({
    super.key,
    this.borderColor = Colors.white,
    this.strokeWidth = 2,
  });

  final Color? borderColor;
  final double? strokeWidth;

  @override
  State<RegionBorder> createState() => _RegionBorderState();
}

class _RegionBorderState extends State<RegionBorder> {
  String regionsRegex = '';

  late final geojsonparser.GeoJsonParser _geoJsonParser;

  @override
  void initState() {
    super.initState();

    _geoJsonParser = geojsonparser.GeoJsonParser(
      defaultPolylineColor: widget.borderColor ?? Colors.white,
      defaultPolygonFillColor: widget.borderColor ?? Colors.white,
      defaultPolylineStroke: widget.strokeWidth ?? 2,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initGeojson();
    });
  }

  void _initGeojson() {
    final cubit = BlocProvider.of<RegionBorderCubit>(context);

    if (cubit.state.provinceBorder == null) {
      if (cubit.state.status.isInitial || cubit.state.status.isFailure) {
        cubit.getRegionBorder();
      }

      cubit.stream.listen((state) {
        if (state.provinceBorder != null && cubit.state.status.isSuccess) {
          _buildGeojson(state.provinceBorder!);
        }
      });
    } else {
      final polygon = cubit.state.provinceBorder!;

      _buildGeojson(polygon);
    }
  }

  Future<void> processData(String geoJson) async {
    try {
      return _geoJsonParser.parseGeoJsonAsString(geoJson);
    } catch (e) {
      log.e(e.toString());

      return;
    }
  }

  Polygon createDefaultPolygon(List<LatLng> outerRing,
      List<List<LatLng>>? holesList, Map<String, dynamic> properties) {
    return Polygon(
      points: outerRing,
      holePointsList: holesList,
      borderColor: widget.borderColor ?? Colors.white,
      color: const Color.fromARGB(0, 5, 3, 3),
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ) ??
          const TextStyle(),
      borderStrokeWidth: 1,
    );
  }

  Future<void> _buildGeojson(String provinceBorder) async {
    _geoJsonParser.polygonCreationCallback = createDefaultPolygon;

    _geoJsonParser.clearMarker();

    processData(provinceBorder).then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return PolygonLayer(polygons: _geoJsonParser.polygons);
  }
}
