import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/core/shared/presentation/cubits/cubits/playback_cubit.dart';

import '../cubit/satelite_cubit.dart';

class SateliteImageOverlay extends StatefulWidget {
  final ValueNotifier<double> opacityNotifier;
  const SateliteImageOverlay({super.key, required this.opacityNotifier});

  @override
  State<SateliteImageOverlay> createState() => _SateliteImageOverlayState();
}

class _SateliteImageOverlayState extends State<SateliteImageOverlay> {
  String? _cacheKey;
  LatLngBounds? _bounds;
  ImageProvider? _imageProvider;

  @override
  void initState() {
    super.initState();
    final state = context.read<SateliteCubit>().state;

    if (state is! SateliteLoaded) return;

    _prepareAndSetImage(state);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SateliteCubit, SateliteState>(
          listenWhen: (previous, current) {
            if (current is! SateliteLoaded) return false;
            if (previous is! SateliteLoaded) return true;

            return previous.images != current.images;
          },
          listener: (context, state) {
            if (state is SateliteLoaded) {
              _prepareAndSetImage(state);
            }
          },
        ),
        BlocListener<PlaybackCubit, PlaybackState>(
          listenWhen: (previous, current) => previous.index != current.index,
          listener: (context, state) {
            final selectionState = context.read<SateliteCubit>().state;
            if (selectionState is SateliteLoaded) {
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

  Future<void> _prepareAndSetImage(SateliteLoaded state) async {
    final currentIndex = BlocProvider.of<PlaybackCubit>(context).state.index;

    final image = state.images[currentIndex];

    final provider = CachedNetworkImageProvider(
      image.imageUrl,
      cacheKey: image.id,
      cacheManager: _createCacheManager(image.id),
    );

    try {
      await precacheImage(provider, context);
    } catch (_) {}

    if (!mounted) return;

    setState(() {
      _cacheKey = image.id;
      _bounds = LatLngBounds(const LatLng(20, 90), const LatLng(-20, 150));
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
        fileService: HttpFileService(
          httpClient: _HeaderHttpClient({'User-Agent': 'okhttp/4.12.0'}),
        ),
      ),
    );
  }
}

class _HeaderHttpClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _inner;

  _HeaderHttpClient(this._headers, [http.Client? inner])
    : _inner = inner ?? http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _inner.send(request);
  }
}
