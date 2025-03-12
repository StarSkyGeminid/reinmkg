import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geojson/geojson.dart';
import 'package:reinmkg/utils/helper/common.dart';

import '../cubit/geojson/fault_line/fault_line_data_cubit.dart';
import 'geojson_parser.dart';

class FaultLineMarker extends StatefulWidget {
  const FaultLineMarker({super.key});

  @override
  State<FaultLineMarker> createState() => _FaultLineMarkerState();
}

class _FaultLineMarkerState extends State<FaultLineMarker> {
  List<GeoJsonFeature<dynamic>>? data;

  GeoJsonParser geoJsonParser = GeoJsonParser(
      defaultPolylineColor: Colors.orange.withOpacity(0.5),
      defaultPolylineStroke: 2);

  Future<void> processData(String geoJson) {
    return geoJsonParser.parseGeoJsonAsString(geoJson);
  }

  @override
  void initState() {
    super.initState();

    _drawPolygon();
  }

  void _drawPolygon() {
    final cubit = BlocProvider.of<FaultLineDataCubit>(context);

    log.d('Drawing fault lines');

    if (cubit.state.faultLine == null) {
      if (cubit.state.status.isInitial || cubit.state.status.isFailure) {
        cubit.getFaultLine();
      }

      cubit.stream.listen((state) {
        if (state.faultLine != null && cubit.state.status.isSuccess) {
          _buildGeojson(state.faultLine!);
        }
      });
    } else {
      final polygon = cubit.state.faultLine!;

      _buildGeojson(polygon);
    }
  }

  Future<void> _buildGeojson(String faultLine) async {
    final geojson = GeoJson();
    await geojson.parse(faultLine);

    setState(() {
      data = geojson.features;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Polyline> polylines = [];
    // List<Marker> _markers = [];

    if (data != null) {
      for (var data in data!) {
        if (data.type == GeoJsonFeatureType.line) {
          GeoJsonLine line = data.geometry;
          final poly = Polyline(
            points: line.geoSerie!.toLatLng(),
            borderColor: Colors.transparent,
            strokeWidth: 1,
            color: Colors.orange,
            borderStrokeWidth: 1,
          );
          polylines.add(poly);
          // lines.add(data.geometry);
        }
      }
    }

    return PolylineLayer(polylines: polylines);
  }
}
