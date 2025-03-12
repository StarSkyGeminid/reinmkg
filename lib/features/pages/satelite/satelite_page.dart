import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/features/features.dart';

import '../../../core/widgets/circular_back_button.dart';
import 'widget/widget.dart';

class SatelitePage extends StatefulWidget {
  const SatelitePage({super.key});

  @override
  State<SatelitePage> createState() => _SatelitePageState();
}

class _SatelitePageState extends State<SatelitePage> {
  final MapController _controller = MapController();

  final ValueNotifier<double> _opacityNotifier = ValueNotifier(0.9);

  @override
  void initState() {
    super.initState();

    _controller.mapEventStream.listen((value) {
      if (value.camera.zoom > 9) {
        _opacityNotifier.value = 0.5;
      } else {
        _opacityNotifier.value = 0.9;
      }
    });
  }

  void _moveToUserPosition() {
    final position =
        BlocProvider.of<LocationCubit>(context).state.location?.toLatLng();

    if (position == null) return;

    _controller.move(position, 9);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseMap(
        onMapReady: _moveToUserPosition,
        mapController: _controller,
        children: [
          _imageOverlay(),
          const RegionBorder(),
          Padding(
            padding: const EdgeInsets.only(top: 9.0).h,
            child: _dateTimeView(),
          ),
          const SafeArea(child: CircularBackButton()),
          const Align(
            alignment: Alignment.bottomLeft,
            child: SateliteLegend(),
          ),
        ],
      ),
    );
  }

  BlocBuilder<SateliteImagesCubit, SateliteImagesState> _dateTimeView() {
    return BlocBuilder<SateliteImagesCubit, SateliteImagesState>(
      builder: (context, state) {
        if (!state.status.isSuccess) {
          return const SizedBox.shrink();
        }

        final fileName = _getFileName(state.images!.first);

        final date = _parseDate(_getFileName(fileName))?.toLocal();

        if (date == null) return const SizedBox.shrink();

        final dateString =
            DateFormat('dd-MM-yyyy HH:mm').format(date.toLocal());

        return SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Text(dateString),
            ),
          ),
        );
      },
    );
  }

  DateTime? _parseDate(String fileName) {
    final regExp =
        RegExp(r'^H08_ET_Indonesia_(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})\.png$');

    var match = regExp.firstMatch(fileName);

    if (match == null) return null;

    String year = match.group(1)!;
    String month = match.group(2)!;
    String day = match.group(3)!;
    String hour = match.group(4)!;
    String minute = match.group(5)!;

    return DateTime.utc(
      int.parse(year),
      int.parse(month),
      int.parse(day),
      int.parse(hour),
      int.parse(minute),
    );
  }

  Widget _imageOverlay() {
    return BlocBuilder<SateliteImagesCubit, SateliteImagesState>(
      builder: (context, state) {
        if (!state.status.isSuccess) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return ValueListenableBuilder(
          valueListenable: _opacityNotifier,
          builder: (context, opacity, _) {
            return OverlayImageLayer(
              overlayImages: [
                _overlayImageLayer(state.images!.first, opacity),
              ],
            );
          },
        );
      },
    );
  }

  OverlayImage _overlayImageLayer(String url, double opacity) {
    final key = _getFileName(url);

    return OverlayImage(
      imageProvider: CachedNetworkImageProvider(
        url,
        cacheManager: CacheManager(
          Config(
            key,
            stalePeriod: const Duration(hours: 1),
            maxNrOfCacheObjects: 5,
            repo: JsonCacheInfoRepository(databaseName: key),
            fileSystem: IOFileSystem(key),
            fileService: HttpFileService(),
          ),
        ),
      ),
      opacity: opacity,
      bounds: LatLngBounds(
        const LatLng(20, 90),
        const LatLng(-20, 150),
      ),
    );
  }

  String _getFileName(String fileName) => fileName.split('/').last;
}
