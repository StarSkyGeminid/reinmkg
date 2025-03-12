import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/utils/ext/ext.dart';

import '../../../../core/localization/l10n/generated/strings.dart';
import '../../../../domain/entities/earthquake/earthquake_entity.dart';
import '../../../widgets/base_map.dart';

class EarthquakeCard extends StatelessWidget {
  const EarthquakeCard({super.key, required this.earthquake});

  final EarthquakeEntity earthquake;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      width: 1.sw,
      height: 100.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMap(),
          _earthquakeData(context),
        ],
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
                      text: Strings.of(context)
                          .tsunamiEarlyWarning(tsunamiWarning),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                earthquake.area ?? '-',
                maxLines: 5,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '${earthquake.time?.toDateTimeString(context: context) ?? '-'} ${earthquake.time?.timeZoneName ?? '-'}',
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w300),
                ),
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
        height: 100.h,
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: _map(),
        ),
      ),
    );
  }

  Widget _map() {
    return AbsorbPointer(
      child: BaseMap(
        mapOptions: MapOptions(
          initialCenter: earthquake.point?.toLatLng() ??
              const LatLng(-7.8032074, 110.3542454),
          interactionOptions:
              const InteractionOptions(flags: InteractiveFlag.none),
          initialZoom: 4,
        ),
        children: [
          MarkerLayer(
            markers: [
              _addMarker(earthquake),
            ],
          ),
        ],
      ),
    );
  }

  Marker _addMarker(EarthquakeEntity earthquakeEntity) {
    Color iconColor = _getMarkerColor(earthquakeEntity.depth!);

    return Marker(
      point: earthquakeEntity.point!.toLatLng() ??
          const LatLng(-7.8032074, 110.3542454),
      width: 80,
      height: 80,
      rotate: false,
      child: Icon(
        Icons.circle,
        color: iconColor.withOpacity(0.8),
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
