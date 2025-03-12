import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/features/features.dart';

import '../../widgets/maritime_segment_marker.dart';
import 'widget/widget.dart';

class MaritimeWeatherPage extends StatefulWidget {
  const MaritimeWeatherPage({super.key});

  @override
  State<MaritimeWeatherPage> createState() => _MaritimeWeatherPageState();
}

class _MaritimeWeatherPageState extends State<MaritimeWeatherPage> {
  final MapController _controller = MapController();

  void _moveToUserPosition() {
    final position =
        BlocProvider.of<LocationCubit>(context).state.location?.toLatLng();

    if (position == null) return;

    _controller.move(position, 6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseMap(
        mapController: _controller,
        onMapReady: _moveToUserPosition,
        children: [
          _buildSegment(),
          const SafeArea(child: CircularBackButton()),
          SafeArea(
            child: Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(top: 9).h,
              child: const MaritimeWeatherDate(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegment() {
    return BlocBuilder<WaterWaveCubit, WaterWaveState>(
      builder: (context, state) {
        if (!state.status.isSuccess) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return MaritimeSegmentMarker(
          waterWaves: state.waves!,
        );
      },
    );
  }
}
