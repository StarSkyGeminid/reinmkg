import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:reinmkg/core/shared/presentation/cubits/cubits/playback_cubit.dart';

import '../cubit/radar_selection/radar_selection_cubit.dart';

class RadarImageOverlay extends StatefulWidget {
  final ValueNotifier<double> opacityNotifier;
  const RadarImageOverlay({super.key, required this.opacityNotifier});

  @override
  State<RadarImageOverlay> createState() => _RadarImageOverlayState();
}

class _RadarImageOverlayState extends State<RadarImageOverlay> {
  String? _cacheKey;
  LatLngBounds? _bounds;
  ImageProvider? _imageProvider;

  @override
  void initState() {
    super.initState();
    final state = context.read<RadarSelectionCubit>().state;

    if (state is! RadarSelectionLoaded) return;

    _prepareAndSetImage(state);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RadarSelectionCubit, RadarSelectionState>(
          listenWhen: (previous, current) {
            if (current is! RadarSelectionLoaded) return false;
            if (previous is! RadarSelectionLoaded) return true;

            return previous.images != current.images;
          },
          listener: (context, state) {
            if (state is RadarSelectionLoaded) {
              _prepareAndSetImage(state);
            }
          },
        ),
        BlocListener<PlaybackCubit, PlaybackState>(
          listenWhen: (previous, current) => previous.index != current.index,
          listener: (context, state) {
            final selectionState = context.read<RadarSelectionCubit>().state;
            if (selectionState is RadarSelectionLoaded) {
              _prepareAndSetImage(selectionState);
            }
          },
        ),
      ],
      child: ValueListenableBuilder<double>(
        valueListenable: widget.opacityNotifier,
        builder: (context, opacity, _) {
          final child = (_imageProvider == null || _bounds == null)
              ? const SizedBox.shrink()
              : OverlayImageLayer(
                  key: Key(_cacheKey ?? 'radar_image_empty'),
                  overlayImages: [
                    OverlayImage(
                      key: Key(_cacheKey ?? 'radar_image_empty_inner'),
                      bounds: _bounds!,
                      imageProvider: _imageProvider!,
                      opacity: opacity,
                    ),
                  ],
                );

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: child,
          );
        },
      ),
    );
  }

  Future<void> _prepareAndSetImage(RadarSelectionLoaded state) async {
    final radar = state.radar;

    final currentIndex = BlocProvider.of<PlaybackCubit>(context).state.index;

    final image = state.images[currentIndex];
    if (radar.tlc == null || radar.brc == null || image.file == null) return;

    final fileName = image.file!.split('/').last.split('.').first;
    final cacheName = '${fileName}_${image.type?.name ?? '-'}';

    final provider = CachedNetworkImageProvider(
      image.file!,
      cacheKey: cacheName,
      cacheManager: _createCacheManager(cacheName),
    );

    try {
      await precacheImage(provider, context);
    } catch (_) {
    }
    
    if (!mounted) return;

    setState(() {
      _cacheKey = cacheName;
      _bounds = LatLngBounds(radar.tlc!, radar.brc!);
      _imageProvider = provider;
    });
  }

  CacheManager _createCacheManager(String cacheName) {
    return CacheManager(
      Config(
        cacheName,
        stalePeriod: const Duration(hours: 5),
        maxNrOfCacheObjects: 20,
        repo: JsonCacheInfoRepository(databaseName: cacheName),
        fileSystem: IOFileSystem(cacheName),
        fileService: HttpFileService(),
      ),
    );
  }
}
