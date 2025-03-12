import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/app_route.dart';
import '../../../../domain/entities/earthquake/earthquake_entity.dart';
import '../../../bloc/earthquake/selectable_earthquake/selectable_earthquake_bloc.dart';
import '../../../widgets/base_map.dart';
import '../../../widgets/fault_line_marker.dart';
import 'earthquake_data.dart';
import '../../../../core/widgets/pulse_point.dart';

class EarthquakeCard extends StatefulWidget {
  const EarthquakeCard({
    super.key,
    required this.title,
    required this.earthquakeStream,
  });

  final String title;
  final Stream<EarthquakeEntity> earthquakeStream;

  @override
  State<EarthquakeCard> createState() => _EarthquakeCardState();
}

class _EarthquakeCardState extends State<EarthquakeCard> {
  final MapController mapController = MapController();

  EarthquakeEntity? earthquake;

  @override
  void initState() {
    widget.earthquakeStream.listen((earthquake) {
      mapController.move(earthquake.point!.toLatLng()!, 6);
    });

    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  Widget _buildView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: GestureDetector(
            onTap: _handleCardTap,
            child: Hero(
              tag: 'EarthquakeMap.${widget.title}',
              child: Center(
                child: AbsorbPointer(child: _earthQuakeInfo()),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleCardTap() {
    if (earthquake == null) return;

    BlocProvider.of<SelectableEarthquakeBloc>(context)
        .add(SelectableEarthquakeEvent.setEarthquake(earthquake!));

    return context.go(
      Routes.earthquake.path,
      extra: 'EarthquakeMap.${widget.title}',
    );
  }

  Widget _earthQuakeInfo() {
    return AspectRatio(
      aspectRatio: 4 / 4,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        height: 300.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.01),
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: BaseMap(
                  mapController: mapController,
                  mapOptions: const MapOptions(
                    interactionOptions:
                        InteractionOptions(flags: InteractiveFlag.none),
                  ),
                  children: [
                    const FaultLineMarker(),
                    _markerLayer(),
                  ],
                ),
              ),
              Expanded(
                child: _earthquakeData(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<EarthquakeEntity> _earthquakeData() {
    return StreamBuilder(
        stream: widget.earthquakeStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();
          }

          earthquake = snapshot.data;

          return EarthquakeData(
            earthquake: snapshot.data,
          );
        });
  }

  StreamBuilder<EarthquakeEntity> _markerLayer() {
    return StreamBuilder(
      stream: widget.earthquakeStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        return MarkerLayer(
          markers: [
            Marker(
              point: snapshot.data?.point?.toLatLng() ??
                  const LatLng(-6.175403, 106.824584),
              child: const PulsePoint(),
            ),
          ],
        );
      },
    );
  }
}
