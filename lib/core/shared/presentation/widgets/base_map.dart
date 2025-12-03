import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BaseMap extends StatefulWidget {
  const BaseMap({
    super.key,
    this.mapController,
    this.children,
    this.onMapReady,
    this.keepAlive = false,
    this.mapOptions,
  });

  final MapController? mapController;
  final List<Widget>? children;
  final VoidCallback? onMapReady;
  final MapOptions? mapOptions;
  final bool keepAlive;

  @override
  State<BaseMap> createState() => _BaseMapState();
}

class _BaseMapState extends State<BaseMap> {
  @override
  Widget build(BuildContext context) {
    return _map();
  }

  FlutterMap _map() {
    return FlutterMap(
      mapController: widget.mapController,
      options:
          widget.mapOptions ??
          MapOptions(
            initialCenter: const LatLng(-6.175307, 106.8249059),
            initialZoom: 6,
            onMapReady: () {
              if (widget.onMapReady != null) {
                widget.onMapReady!();
              }
            },
            keepAlive: widget.keepAlive,
          ),
      children: [
        TileLayer(
          urlTemplate:
              'https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Dark_Gray_Base/MapServer/tile/{z}/{y}/{x}', // OSMF's Tile Server
        ),
        if (widget.children != null) ...widget.children!,
      ],
    );
  }
}
