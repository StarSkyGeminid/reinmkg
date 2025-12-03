import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/core/shared/presentation/widgets/base_map.dart';
import 'package:reinmkg/core/utils/extension/datetime.dart';

import '../../domain/entities/earthquake_entity.dart';

class EarthquakeTile extends StatelessWidget {
  const EarthquakeTile({super.key, required this.earthquake});

  final EarthquakeEntity earthquake;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildMap(), _earthquakeData(context)],
      ),
    );
  }

  Widget _earthquakeData(BuildContext context) {
    final tsunamiWarning = (earthquake.subject?.contains('PD') ?? false)
        ? earthquake.subject?.split('PD-')[1] ?? ''
        : '';

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${earthquake.magnitude ?? '-'} SR',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (earthquake.tsunamiData != null)
                    TextSpan(
                      text: ' - ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (earthquake.tsunamiData != null)
                    TextSpan(
                      text: 'Tsunami $tsunamiWarning',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            Text(
              earthquake.area ?? '-',
              maxLines: 5,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                earthquake.time?.toDateTimeString(withTimezone: true) ?? '-',
                maxLines: 2,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ClipRRect _buildMap() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      child: SizedBox(
        height: 100,
        child: AspectRatio(aspectRatio: 1 / 1, child: _map()),
      ),
    );
  }

  Widget _map() {
    return AbsorbPointer(
      child: BaseMap(
        mapOptions: MapOptions(
          initialCenter:
              earthquake.point?.toLatLng() ??
              const LatLng(-7.8032074, 110.3542454),
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.none,
          ),
          initialZoom: 4,
        ),
        children: [
          MarkerLayer(markers: [_addMarker(earthquake)]),
        ],
      ),
    );
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
      child: Icon(
        Icons.circle,
        color: iconColor.withValues(alpha: 0.8),
        size: _getMarkerSize(earthquakeEntity.magnitude!),
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
