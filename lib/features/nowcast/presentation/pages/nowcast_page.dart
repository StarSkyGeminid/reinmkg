import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';
import 'package:reinmkg/core/shared/presentation/widgets/base_map.dart';
import 'package:reinmkg/core/shared/presentation/widgets/circular_back_button.dart';
import 'package:reinmkg/features/general/location/presentation/cubit/location_cubit.dart';

import '../../domain/entities/weather_nowcast_entity.dart';
import '../widgets/nowcast_bottomsheet.dart';
import '../widgets/warning_area_marker.dart';

class NowcastPage extends StatefulWidget {
  const NowcastPage({super.key, this.nowcast});

  final WeatherNowcastEntity? nowcast;

  @override
  State<NowcastPage> createState() => _NowcastPageState();
}

class _NowcastPageState extends State<NowcastPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? _bottomSheetController;

  final MapController _controller = MapController();

  @override
  void initState() {
    super.initState();

    if (widget.nowcast != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showNowcastBottomSheet(widget.nowcast!);
      });
    }
  }

  @override
  void didUpdateWidget(covariant NowcastPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.nowcast == null && widget.nowcast != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showNowcastBottomSheet(widget.nowcast!);
      });
    }
  }

  void _showNowcastBottomSheet(WeatherNowcastEntity nowcast) {
    if (_bottomSheetController != null) {
      try {
        _bottomSheetController!.close();
      } catch (_) {}
      _bottomSheetController = null;
    }

    final sheetController = DraggableScrollableController();

    final sheet = _scaffoldKey.currentState?.showBottomSheet((context) {
      return NowcastBottomsheet(
        draggableScrollableController: sheetController,
        nowcast: nowcast,
      );
    });

    _bottomSheetController = sheet;

    _bottomSheetController?.closed.then((_) {
      _bottomSheetController = null;
    });
  }

  void _moveToUserPosition() {
    final state = BlocProvider.of<LocationCubit>(context).state;

    if (state is LocationLoaded) {
      final position = state.location.toLatLng();

      if (position != null) {
        _controller.move(position, 6);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listenWhen: (previous, current) =>
          current is LocationLoaded &&
          previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        if (state is LocationLoaded) {
          final pos = state.location.toLatLng();

          if (pos != null) {
            _controller.move(pos, 6);
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: BaseMap(
          mapController: _controller,
          onMapReady: _moveToUserPosition,
          children: [
            WarningAreaMarker(
              onTap: (nowcast) {
                _showNowcastBottomSheet(nowcast);
              },
            ),
            const SafeArea(child: CircularBackButton()),
            RichAttributionWidget(
              showFlutterMapAttribution: false,
              attributions: [
                TextSourceAttribution(Strings.of(context).mapTileAttribution),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
