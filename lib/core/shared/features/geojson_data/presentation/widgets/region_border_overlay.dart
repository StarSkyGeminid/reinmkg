import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:latlong2/latlong.dart';

import '../cubit/region_border_overlay/region_border_overlay_cubit.dart';

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

  late final GeoJsonParser _geoJsonParser;

  @override
  void initState() {
    super.initState();

    _geoJsonParser = GeoJsonParser(
      defaultPolylineColor: widget.borderColor ?? Colors.white,
      defaultPolygonFillColor: widget.borderColor ?? Colors.white,
      defaultPolylineStroke: widget.strokeWidth ?? 2,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initGeojson();
    });
  }

  void _initGeojson() {
    final cubit = BlocProvider.of<RegionBorderOverlayCubit>(context);

    if (cubit.state.border == null) {
      cubit.getRegionBorder();

      cubit.stream.listen((state) {
        if (state.border != null) {
          _buildGeojson(state.border!);
        }
      });
    } else {
      final polygon = cubit.state.border!;

      _buildGeojson(polygon);
    }
  }

  Future<void> processData(String geoJson) async {
    try {
      return _geoJsonParser.parseGeoJsonAsString(geoJson);
    } catch (e) {
      return;
    }
  }

  Polygon createDefaultPolygon(
    List<LatLng> outerRing,
    List<List<LatLng>>? holesList,
    Map<String, dynamic> properties,
  ) {
    return Polygon(
      points: outerRing,
      holePointsList: holesList,
      borderColor: widget.borderColor ?? Colors.white,
      color: const Color.fromARGB(0, 5, 3, 3),
      labelStyle:
          Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold) ??
          const TextStyle(),
      borderStrokeWidth: 1,
    );
  }

  Future<void> _buildGeojson(String border) async {
    _geoJsonParser.polygonCreationCallback = createDefaultPolygon;

    processData(border).then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return PolygonLayer(polygons: _geoJsonParser.polygons);
  }
}
