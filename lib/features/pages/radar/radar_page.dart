import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/domain/entities/weather/radar/radar_entity.dart';
import 'package:reinmkg/features/features.dart';

import '../../../core/widgets/circular_back_button.dart';
import '../../../dependencies_injection.dart';
import '../../../domain/entities/weather/radar/radar_image_entity.dart';

class RadarPage extends StatefulWidget {
  const RadarPage({super.key});

  @override
  State<RadarPage> createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> {
  final MapController _controller = MapController();

  bool isMapReady = false;

  final ValueNotifier<double> _opacityNotifier = ValueNotifier(1.0);
  final ValueNotifier<LatLng> _userLocation =
      ValueNotifier(const LatLng(-6.175307, 106.8249059));

  @override
  void initState() {
    super.initState();

    final position =
        BlocProvider.of<LocationCubit>(context).state.location?.toLatLng();

    if (position == null) return;

    BlocProvider.of<NearestCloudRadarCubit>(context)
        .getNearestCloudRadar(position);
  }

  void _listenCamera() {
    _controller.mapEventStream.listen((value) {
      if (value.camera.zoom > 9) {
        _opacityNotifier.value = 0.5;
      } else {
        _opacityNotifier.value = 1.0;
      }
    });
  }

  void _onMapReady() {
    _listenCamera();
    _drawUserPosition();

    isMapReady = true;
  }

  void _drawUserPosition() {
    final position =
        BlocProvider.of<LocationCubit>(context).state.location?.toLatLng();

    if (position == null) return;

    _userLocation.value = position;
  }

  void _onSearchRadar() {
    showDialog(
      context: context,
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<SelectableRadarBloc>(),
            ),
            BlocProvider<SearchCloudRadarBloc>(
              create: (context) =>
                  sl()..add(const SearchCloudRadarEvent.started()),
            ),
          ],
          child: const SearchRadarDialog(),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectableRadarBloc, SelectableRadarState>(
      listenWhen: (previous, current) =>
          previous.selectedRadar != current.selectedRadar,
      listener: (context, state) {
        if ((state.selectedRadar?.position != null) && isMapReady) {
          _controller.move(state.selectedRadar!.position!, 7);
        }
      },
      child: Scaffold(
        body: BaseMap(
          onMapReady: _onMapReady,
          mapController: _controller,
          children: [
            _cicrleOverlay(),
            _imageOverlay(),
            const RegionBorder(),
            _currentPosition(),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircularBackButton(),
                    BlocBuilder<SelectableRadarBloc, SelectableRadarState>(
                      buildWhen: (previous, current) =>
                          previous.selectedRadar != current.selectedRadar,
                      builder: (context, state) {
                        return RadarDate(
                          location: state.selectedRadar?.city,
                        );
                      },
                    ),
                    SearchRadarButton(
                      onTap: _onSearchRadar,
                    ),
                  ],
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: RadarMenu(),
            ),
          ],
        ),
      ),
    );
  }

  ValueListenableBuilder<LatLng> _currentPosition() {
    return ValueListenableBuilder(
      valueListenable: _userLocation,
      builder: (context, point, _) {
        return MarkerLayer(
          markers: [
            Marker(
                point: point, child: const Icon(Symbols.my_location_rounded)),
          ],
        );
      },
    );
  }

  Widget _cicrleOverlay() {
    return BlocBuilder<SelectableRadarBloc, SelectableRadarState>(
      builder: (context, state) {
        if (!state.status.isSuccess) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        final tlc = state.selectedRadar?.tlc;
        final brc = state.selectedRadar?.brc;

        if (tlc == null || brc == null) {
          return const SizedBox.shrink();
        }

        final radius = _getRadius(tlc, brc);

        return state.selectedRadar != null
            ? CircleLayer(
                circles: [
                  CircleMarker(
                    point: state.selectedRadar!.position!,
                    radius: radius,
                    useRadiusInMeter: true,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }

  double _getRadius(LatLng tlc, LatLng brc) {
    const Distance distance = Distance();

    final radius = distance.as(
            LengthUnit.Meter, tlc, LatLng(brc.latitude, tlc.longitude)) /
        2;
    return radius;
  }

  Widget _imageOverlay() {
    return BlocBuilder<SelectableRadarBloc, SelectableRadarState>(
      buildWhen: (previous, current) =>
          previous.selectedRadarImages != current.selectedRadarImages,
      builder: (context, state) {
        if (state.selectedRadarImages == null) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return state.selectedRadarImages != null
            ? ValueListenableBuilder(
                valueListenable: _opacityNotifier,
                builder: (context, opacity, _) {
                  return Animate(
                    autoPlay: true,
                    effects: const [
                      FadeEffect(duration: Duration(milliseconds: 150))
                    ],
                    child: OverlayImageLayer(
                      overlayImages: [
                        convertOverlayImage(state.selectedRadar!,
                            state.selectedRadarImages!, opacity),
                      ],
                    ),
                  );
                })
            : const SizedBox.shrink();
      },
    );
  }

  OverlayImage convertOverlayImage(
      RadarEntity radar, RadarImageEntity image, double opacity) {
    var fileName = image.file!.split('/').last.split('.').first;
    final cacheName = '${fileName}_${image.type?.name ?? '-'}';

    return OverlayImage(
      key: Key(cacheName),
      bounds: LatLngBounds(radar.tlc!, radar.brc!),
      imageProvider: CachedNetworkImageProvider(
        image.file!,
        cacheKey: cacheName,
        cacheManager: CacheManager(
          Config(
            cacheName,
            stalePeriod: const Duration(hours: 5),
            maxNrOfCacheObjects: 20,
            repo: JsonCacheInfoRepository(databaseName: cacheName),
            fileSystem: IOFileSystem(cacheName),
            fileService: HttpFileService(),
          ),
        ),
      ),
      opacity: opacity,
    );
  }
}
