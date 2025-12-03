import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';
import 'package:reinmkg/core/shared/features/geojson_data/presentation/widgets/fault_line_marker.dart';
import 'package:reinmkg/core/shared/presentation/widgets/base_map.dart';
import 'package:reinmkg/features/earthquake/presentation/cubit/cubit.dart';

import 'widgets.dart';

class EarthquakeMapView extends StatefulWidget {
  const EarthquakeMapView({
    super.key,
    this.heroKey,
    required this.onRequestHide,
  });

  final String? heroKey;
  final void Function(bool) onRequestHide;

  @override
  State<EarthquakeMapView> createState() => _EarthquakeMapViewState();
}

class _EarthquakeMapViewState extends State<EarthquakeMapView>
    with SingleTickerProviderStateMixin {
  final MapController mapController = MapController();
  final DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  final ValueNotifier<double> bottomSheetHeightNotifier = ValueNotifier<double>(
    0.0,
  );

  late final AnimationController _fabController;
  late final Animation<Offset> _fabOffset;

  StreamSubscription<dynamic>? _selectableSub;

  bool isMapReady = false;
  bool isHidden = false;

  String lastHeroKey = 'EarthquakeMap';

  double lastBottomSheetHeight = 0.0;

  @override
  void initState() {
    super.initState();

    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fabOffset = Tween<Offset>(
      begin: const Offset(0, 1.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeOut));

    BlocProvider.of<SelectableEarthquakeCubit>(context).startListening();

    _selectableSub = BlocProvider.of<SelectableEarthquakeCubit>(context).stream
        .listen((state) {
          final earthquake = state is SelectableEarthquakeSelected
              ? state.earthquake
              : null;

          final shouldShow =
              earthquake != null && earthquake.isFelt && !isHidden;

          if (shouldShow) {
            _fabController.forward();
          } else {
            _fabController.reverse();
          }
        });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var height = context.size?.height ?? 0.0;
      bottomSheetHeightNotifier.value = height * 0.25;

      _handleDragOffset();
    });
  }

  void _handleDragOffset() {
    draggableScrollableController.addListener(() {
      if (!draggableScrollableController.isAttached) return;

      final wasHidden = isHidden;

      if (draggableScrollableController.size > 0.7 && !isHidden) {
        isHidden = true;
        widget.onRequestHide(true);
      } else if (draggableScrollableController.size < 0.7 && isHidden) {
        isHidden = false;
        widget.onRequestHide(false);
      }

      if (wasHidden != isHidden) {
        if (isHidden) {
          _fabController.reverse();
        } else {
          final state = BlocProvider.of<SelectableEarthquakeCubit>(
            context,
          ).state;
          final earthquake = state is SelectableEarthquakeSelected
              ? state.earthquake
              : null;
          if (earthquake != null && earthquake.isFelt) {
            _fabController.forward();
          }
        }
      }

      final height = draggableScrollableController.pixels;

      if (lastBottomSheetHeight != 0.0) {
        final center = mapController.camera.center;
        final zoom = mapController.camera.zoom;

        final offset = Offset(0, (lastBottomSheetHeight - height) * 0.7);

        mapController.move(center, zoom, offset: offset);

        bottomSheetHeightNotifier.value = height;
      }

      lastBottomSheetHeight = height;
    });
  }

  @override
  void dispose() {
    mapController.dispose();
    draggableScrollableController.dispose();
    _selectableSub?.cancel();
    _fabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isMapReady && lastHeroKey != widget.heroKey && widget.heroKey != null) {
      lastHeroKey = widget.heroKey ?? 'EarthquakeMap';

      mapController.move(mapController.camera.center, 6);
    } else if (!isMapReady && widget.heroKey != null) {
      lastHeroKey = widget.heroKey ?? 'EarthquakeMap';
    }

    return Hero(
      tag: lastHeroKey,
      child: BaseMap(
        mapController: mapController,
        keepAlive: true,
        onMapReady: () {
          isMapReady = true;
        },
        children: [
          const MMIMarker(),
          const FaultLineMarker(),

          EarthquakeMapMarkerLayer(
            mapController: mapController,
            autoSelectNewest: widget.heroKey == null,
          ),
          const LegendShower(),
          EarthquakePlaybackFab(
            draggableScrollableController: draggableScrollableController,
            bottomSheetHeightNotifier: bottomSheetHeightNotifier,
            fabOffset: _fabOffset,
            fabController: _fabController,
          ),
          EarthquakeDataBottomSheet(
            draggableScrollableController: draggableScrollableController,
          ),
          RichAttributionWidget(
            showFlutterMapAttribution: false,
            attributions: [
              TextSourceAttribution(Strings.of(context).mapTileAttribution),
            ],
          ),
        ],
      ),
    );
  }
}
