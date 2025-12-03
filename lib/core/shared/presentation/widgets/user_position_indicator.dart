import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/symbols.dart';

class UserPositionIndicator extends StatelessWidget {
  const UserPositionIndicator({super.key, required this.userLocation});

  final ValueNotifier<LatLng> userLocation;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: userLocation,
      builder: (context, point, _) {
        return MarkerLayer(
          markers: [
            Marker(
              point: point,
              child: const Icon(Symbols.my_location_rounded),
            ),
          ],
        );
      },
    );
  }
}
