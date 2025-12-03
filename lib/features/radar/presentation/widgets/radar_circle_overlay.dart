import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/features/features.dart';

class RadarCircleOverlay extends StatelessWidget {
  const RadarCircleOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return _cicrleOverlay();
  }

  Widget _cicrleOverlay() {
    return BlocBuilder<RadarSelectionCubit, RadarSelectionState>(
      builder: (context, state) {
        if (state is! RadarSelectionLoaded) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        final tlc = state.radar.tlc;
        final brc = state.radar.brc;

        if (tlc == null || brc == null) {
          return const SizedBox.shrink();
        }

        final radius = _getRadius(tlc, brc);

        return CircleLayer(
          circles: [
            CircleMarker(
              point: state.radar.position!,
              radius: radius,
              useRadiusInMeter: true,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ],
        );
      },
    );
  }

  double _getRadius(LatLng tlc, LatLng brc) {
    const Distance distance = Distance();

    final radius =
        distance.as(
          LengthUnit.Meter,
          tlc,
          LatLng(brc.latitude, tlc.longitude),
        ) /
        2;
    return radius;
  }
}
