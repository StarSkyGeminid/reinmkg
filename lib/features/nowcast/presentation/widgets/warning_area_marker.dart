import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/core/shared/features/geojson_data/presentation/cubit/province_border_overlay/province_border_overlay_cubit.dart';

import '../../domain/entities/weather_nowcast_entity.dart';
import '../cubit/nowcast_cubit.dart';

class WarningAreaMarker extends StatefulWidget {
  const WarningAreaMarker({super.key, required this.onTap});

  final void Function(WeatherNowcastEntity) onTap;

  @override
  State<WarningAreaMarker> createState() => _WarningAreaMarkerState();
}

class _WarningAreaMarkerState extends State<WarningAreaMarker> {
  final LayerHitNotifier hitNotifier = ValueNotifier(null);

  List<WeatherNowcastEntity> nowcasts = [];
  String regionsRegex = '';

  GeoJsonParser geoJsonParser = GeoJsonParser(
    defaultPolylineColor: Colors.white,
    defaultPolygonFillColor: Colors.white,
    defaultPolylineStroke: 2,
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provinceBorderCubit = BlocProvider.of<ProvinceBorderOverlayCubit>(
        context,
      );

      if (provinceBorderCubit.state.border == null) {
        provinceBorderCubit.getProvinceBorder();

        BlocProvider.of<ProvinceBorderOverlayCubit>(context).stream.listen((
          state,
        ) {
          if (state.border != null) _drawPolygon(state.border!);
        });
      } else {
        _drawPolygon(provinceBorderCubit.state.border!);
      }
    });

    handleTap();
  }

  void handleTap() {
    return hitNotifier.addListener(() {
      try {
        final hit = hitNotifier.value;
        if (hit == null || hit.hitValues.isEmpty) return;

        final properties = hit.hitValues[0];

        if (properties is! String) return;

        final matches = nowcasts.where((element) {
          return element.province != null &&
              element.province!.toUpperCase().endsWith(properties);
        });

        final WeatherNowcastEntity? nowcast = matches.isEmpty
            ? null
            : matches.first;

        if (nowcast == null) return;

        widget.onTap(nowcast);
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

  bool filterRegion(Map<String, dynamic> properties) {
    return properties['WADMPR'].toString().toUpperCase().contains(
      RegExp('($regionsRegex)'),
    );
  }

  Polygon createDefaultPolygon(
    List<LatLng> outerRing,
    List<List<LatLng>>? holesList,
    Map<String, dynamic> properties,
  ) {
    String provinceName = properties['WADMPR'].toUpperCase();

    if (provinceName.contains('KEPULAUAN')) {
      provinceName = provinceName.replaceAll('KEPULAUAN ', '');
    }

    return Polygon(
      points: outerRing,
      holePointsList: holesList,
      borderColor: Colors.black.withValues(alpha: 0.8),
      color: const Color(0xFFFEAF0A),
      borderStrokeWidth: 1,
      label: provinceName,
      labelStyle:
          Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold) ??
          const TextStyle(),
      hitValue: provinceName,
    );
  }

  Future<void> _drawPolygon(String provinceBorder) async {
    BlocProvider.of<NowcastCubit>(context).stream.listen((state) {
      if (state is! NowcastLoaded) return;

      nowcasts = state.nowcasts;

      geoJsonParser = GeoJsonParser(
        defaultPolylineColor: Colors.transparent,
        defaultPolygonFillColor: Colors.transparent,
        defaultPolylineStroke: 2,
      );

      geoJsonParser.filterFunction = filterRegion;

      geoJsonParser.polygonCreationCallback = createDefaultPolygon;

      if (!mounted) return;

      if (nowcasts.isEmpty) {
        setState(() {});
        return;
      }

      regionsRegex = nowcasts
          .map((e) {
            String? province = e.province?.toUpperCase();

            province = (province?.startsWith('DI YOGYAKARTA') ?? false)
                ? 'YOGYAKARTA'
                : province;

            return province;
          })
          .join('|');

      regionsRegex = '($regionsRegex)\$';

      processData(provinceBorder).then((_) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PolygonLayer(
      hitNotifier: hitNotifier,
      polygons: geoJsonParser.polygons,
    );
  }
}
