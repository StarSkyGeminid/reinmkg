import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/core/shared/presentation/widgets/base_map.dart';
import 'package:reinmkg/core/shared/presentation/widgets/circular_back_button.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';

import '../../domain/entities/earthquake_pga_entity.dart';
import '../cubit/seismic_playback_cubit.dart';

class SeismicPlaybackPage extends StatefulWidget {
  final String eventId;
  final DateTime? time;
  final double latitude;
  final double longitude;
  final double magnitude;

  const SeismicPlaybackPage({
    super.key,
    required this.eventId,
    this.time,
    required this.latitude,
    required this.longitude,
    required this.magnitude,
  });

  @override
  State<SeismicPlaybackPage> createState() => _SeismicPlaybackPageState();
}

class _SeismicPlaybackPageState extends State<SeismicPlaybackPage> {
  late final SeismicPlaybackCubit _cubit;
  final _mapController = MapController();

  List<Color> mmiColor = [
    const Color(0xFF0028DD),
    const Color(0xFF007ACC),
    const Color(0xFF11CA57),
    const Color(0xFF81E31D),
    const Color(0xFFE7ED0A),
    const Color(0xFFFEDF0A),
    const Color(0xFFFEAF0A),
    const Color(0xFFFF6F08),
    const Color(0xFFFF3009),
    const Color(0xFFDD1304),
  ];

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SeismicPlaybackCubit>();
    _cubit.load(widget.eventId, baseTime: widget.time);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.move(LatLng(widget.latitude, widget.longitude), 7);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseMap(
        mapController: _mapController,
        children: [
          BlocBuilder<SeismicPlaybackCubit, SeismicPlaybackState>(
            builder: (context, state) {
              final markers = _buildMarkers(state);
              final showEventMarker = state.positionSeconds >= 1.0;
              final allMarkers = List<Marker>.from(markers);

              if (showEventMarker) allMarkers.add(_earthquakeMarker());

              return PopupMarkerLayer(
                options: PopupMarkerLayerOptions(
                  markers: allMarkers,
                  popupDisplayOptions: PopupDisplayOptions(
                    builder: (BuildContext context, Marker marker) {
                      return _popUp(marker);
                    },
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(child: const CircularBackButton()),
          ),

          Align(alignment: Alignment.bottomCenter, child: _buildControls()),
        ],
      ),
    );
  }

  Card _popUp(Marker marker) {
    var isPgaMarker = marker is PgaMarker;
    var title = isPgaMarker
        ? Strings.of(context).seismicStation(marker.pgaEntity.stationId ?? '')
        : Strings.of(context).seismicEpicenter(
            '${widget.magnitude}${Strings.of(context).magnitudeUnit}',
          );

    final List<Widget> children = [
      Text(
        isPgaMarker
            ? Strings.of(context).seismicPga('${marker.pgaEntity.pga ?? ''}')
            : '',
      ),
      Text(
        isPgaMarker
            ? Strings.of(context).seismicPgv('${marker.pgaEntity.pgv ?? ''}')
            : '',
      ),
      Text(
        isPgaMarker
            ? Strings.of(context).seismicMmi('${marker.pgaEntity.mmi ?? ''}')
            : '',
      ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, textAlign: TextAlign.center),
            if (isPgaMarker) ...children,
          ],
        ),
      ),
    );
  }

  List<PgaMarker> _buildMarkers(SeismicPlaybackState state) {
    final active = _cubit.activePga(state.positionSeconds);

    return active
        .map((p) {
          final lat = double.tryParse(p.latitude ?? '');
          final lng = double.tryParse(p.longitude ?? '');
          if (lat == null || lng == null) return null;

          final isActive = active.contains(p);
          return PgaMarker(
            pgaEntity: p,
            point: LatLng(lat, lng),
            height: 20,
            width: 20,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isActive
                    ? mmiColor[(p.mmi ?? 0).clamp(0, 9).toInt()]
                    : Colors.grey.withAlpha(150),
                shape: BoxShape.circle,
              ),
              child: Text(
                (p.mmi ?? 0).toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          );
        })
        .whereType<PgaMarker>()
        .toList();
  }

  Marker _earthquakeMarker() {
    return Marker(
      point: LatLng(widget.latitude, widget.longitude),
      height: 60,
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Symbols.star, fill: 1, size: 32),
          Text('${widget.magnitude}${Strings.of(context).magnitudeUnit}'),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return BlocBuilder<SeismicPlaybackCubit, SeismicPlaybackState>(
      builder: (context, state) {
        final time = widget.time?.add(
          Duration(milliseconds: (state.positionSeconds * 1000).toInt()),
        );

        final timeText = time != null
            ? DateFormat('yyyy-MM-dd HH:mm:ss').format(time)
            : '-';

        return Container(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        state.isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                      onPressed: () =>
                          state.isPlaying ? _cubit.pause() : _cubit.play(),
                    ),
                    Expanded(
                      child: Slider(
                        min: 0.0,
                        max: state.durationSeconds <= 0
                            ? 1.0
                            : state.durationSeconds,
                        value: state.positionSeconds.clamp(
                          0.0,
                          state.durationSeconds <= 0
                              ? 1.0
                              : state.durationSeconds,
                        ),
                        onChanged: (v) => _cubit.seek(v),
                      ),
                    ),
                    Text(
                      '${state.positionSeconds.toStringAsFixed(1)}s / ${state.durationSeconds.toStringAsFixed(1)}s',
                    ),
                  ],
                ),
                Align(alignment: Alignment.center, child: Text(timeText)),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class PgaMarker extends Marker {
  final EarthquakePgaEntity pgaEntity;

  const PgaMarker({
    required this.pgaEntity,
    required super.point,
    required super.height,
    required super.width,
    required super.child,
  });
}
