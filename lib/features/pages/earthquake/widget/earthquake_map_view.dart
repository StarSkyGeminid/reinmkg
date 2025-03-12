import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../bloc/earthquake/selectable_earthquake/selectable_earthquake_bloc.dart';
import '../../../widgets/widgets.dart';
import 'widget.dart';

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

class _EarthquakeMapViewState extends State<EarthquakeMapView> {
  final MapController mapController = MapController();
  final DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  bool isMapReady = false;
  bool isHidden = false;

  String lastHeroKey = 'EarthquakeMap';

  double lastBottomSheetHeight = 0.0;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<SelectableEarthquakeBloc>(context)
        .add(const SelectableEarthquakeEvent.started());

    _handleDragOffset();
  }

  void _handleDragOffset() {
    draggableScrollableController.addListener(() {
      if (!draggableScrollableController.isAttached) return;

      if (draggableScrollableController.size > 0.7 && !isHidden) {
        isHidden = true;

        widget.onRequestHide(true);
      } else if (draggableScrollableController.size < 0.7 && isHidden) {
        isHidden = false;

        widget.onRequestHide(false);
      }

      final height = draggableScrollableController.pixels;

      if (lastBottomSheetHeight != 0.0) {
        final center = mapController.camera.center;
        final zoom = mapController.camera.zoom;

        final offset = Offset(0, (lastBottomSheetHeight - height) * 0.7);

        mapController.move(center, zoom, offset: offset);
      }

      lastBottomSheetHeight = height;
    });
  }

  @override
  void dispose() {
    mapController.dispose();
    draggableScrollableController.dispose();

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
          EarthquakeDataBottomSheet(
            draggableScrollableController: draggableScrollableController,
          ),
        ],
      ),
    );
  }
}
