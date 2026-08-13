import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/features/earthquake/domain/entities/earthquake_entity.dart';
import 'package:reinmkg/features/earthquake/presentation/cubit/cubit.dart';

class EarthquakeMapMarkerLayer extends StatefulWidget {
  const EarthquakeMapMarkerLayer({
    super.key,
    required this.mapController,
    required this.autoSelectNewest,
  });

  final MapController mapController;
  final bool autoSelectNewest;

  @override
  State<EarthquakeMapMarkerLayer> createState() =>
      _EarthquakeMapMarkerLayerState();
}

class _EarthquakeMapMarkerLayerState extends State<EarthquakeMapMarkerLayer> {
  Marker? _marker;
  List<Marker> _cachedMarkers = const [];
  List<EarthquakeEntity>? _cachedEarthquakes;
  StreamSubscription? _selectableSub;

  @override
  void initState() {
    super.initState();

    _selectableSub =
        BlocProvider.of<SelectableEarthquakeCubit>(context).stream.listen((
      state,
    ) {
      if (state is SelectableEarthquakeSelected) {
        final earthquake = state.earthquake;
        final position =
            earthquake.point?.toLatLng() ??
            const LatLng(-7.8032074, 110.3542454);

        _updateMarker(
          position,
          earthquake.depth ?? 0,
          earthquake.magnitude ?? 0,
        );
      }
    });
  }

  @override
  void dispose() {
    _selectableSub?.cancel();
    super.dispose();
  }

  void _updateMarker(LatLng cooordinate, double depth, double magnitude) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.mapController.move(cooordinate, widget.mapController.camera.zoom);
    });

    final color = _getMarkerColor(depth);

    setState(() {
      _marker = Marker(
        point: cooordinate,
        width: 90,
        height: 90,
        rotate: false,
        child: PulsePoint(
          mainColor: color,
          pulseColor: color.withValues(alpha: 0.8),
          size: _getMarkerSize(magnitude),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EarthquakeHistoriesCubit, EarthquakeHistoriesState>(
      listenWhen: (previous, current) {
        final prev = previous is EarthquakeHistoriesLoaded
            ? previous.earthquakes
            : null;
        final curr = current is EarthquakeHistoriesLoaded
            ? current.earthquakes
            : null;
        return prev != curr;
      },
      listener: (context, state) {
        if (widget.autoSelectNewest && state is EarthquakeHistoriesLoaded) {
          final earthquake = state.earthquakes[state.earthquakes.length - 1];

          BlocProvider.of<SelectableEarthquakeCubit>(
            context,
          ).setSelected(earthquake);
        }
      },
      builder: (context, state) {
        if (state is EarthquakeHistoriesLoaded &&
            state.earthquakes != _cachedEarthquakes) {
          _cachedEarthquakes = state.earthquakes;
          _cachedMarkers = _buildMarker(state.earthquakes);
        }

        return MarkerLayer(
          markers: [
            ..._cachedMarkers,
            ?_marker,
          ],
        );
      },
    );
  }

  List<Marker> _buildMarker(List<EarthquakeEntity> earthquakes) {
    List<Marker> markers = [];

    for (var element in earthquakes) {
      markers.add(_addMarker(element));
    }

    return markers;
  }

  Marker _addMarker(EarthquakeEntity earthquakeEntity) {
    Color iconColor = _getMarkerColor(earthquakeEntity.depth!);

    return Marker(
      point:
          earthquakeEntity.point!.toLatLng() ??
          const LatLng(-7.8032074, 110.3542454),
      width: 80,
      height: 80,
      rotate: false,
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<SelectableEarthquakeCubit>(
            context,
          ).setSelected(earthquakeEntity);
        },
        child: Icon(
          Icons.circle,
          color: iconColor.withValues(alpha: 0.8),
          size: _getMarkerSize(earthquakeEntity.magnitude!),
        ),
      ),
    );
  }

  Color _getMarkerColor(double depth) {
    switch (depth) {
      case <= 50:
        return Colors.red;
      case <= 100:
        return Colors.orange;
      case <= 250:
        return Colors.yellow;
      case <= 600:
        return Colors.green;
      case > 600:
        return Colors.blue;
      default:
        return Colors.blue;
    }
  }

  double _getMarkerSize(double magnitude) {
    return magnitude.round() * 4;
  }
}
