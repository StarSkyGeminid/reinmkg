import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';
import 'package:reinmkg/core/shared/features/geojson_data/presentation/widgets/region_border_overlay.dart';
import 'package:reinmkg/core/shared/presentation/cubits/cubits/playback_cubit.dart';
import 'package:reinmkg/core/shared/presentation/widgets/base_map.dart';
import 'package:reinmkg/core/shared/presentation/widgets/circular_back_button.dart';
import 'package:reinmkg/core/shared/presentation/widgets/product_menu.dart';
import 'package:reinmkg/core/shared/presentation/widgets/user_position_indicator.dart';
import 'package:reinmkg/features/general/location/presentation/cubit/location_cubit.dart';
import 'package:reinmkg/features/general/settings/presentation/cubit/settings_cubit.dart';

import '../cubit/satelite_cubit.dart';
import '../widgets/widgets.dart';

class SatelitePage extends StatefulWidget {
  const SatelitePage({super.key});

  @override
  State<SatelitePage> createState() => _SatelitePageState();
}

class _SatelitePageState extends State<SatelitePage> {
  final MapController _controller = MapController();

  final ValueNotifier<double> _opacityNotifier = ValueNotifier(0.9);
  final ValueNotifier<LatLng> _userLocation = ValueNotifier(
    const LatLng(-6.175307, 106.8249059),
  );

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
    final state = BlocProvider.of<LocationCubit>(context).state;

    if (state is LocationLoaded) {
      final position = state.location.toLatLng();

      if (position != null) {
        _controller.move(position, 9);

        _userLocation.value = position;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LocationCubit, LocationState>(
          listenWhen: (previous, current) =>
              current is LocationLoaded &&
              previous.runtimeType != current.runtimeType,
          listener: (context, state) {
            if (state is LocationLoaded) {
              final position = state.location.toLatLng();

              if (position != null) {
                _controller.move(position, 9);
              }
            }
          },
        ),
        BlocListener<SateliteCubit, SateliteState>(
          listenWhen: (previous, current) {
            if (current is! SateliteLoaded) return false;
            if (previous is! SateliteLoaded) return true;

            return previous.images != current.images;
          },
          listener: (context, state) {
            if (state is SateliteLoaded) {
              BlocProvider.of<PlaybackCubit>(
                context,
              ).setMaxIndex(state.images.length);
            }
          },
        ),
      ],
      child: Scaffold(
        body: BaseMap(
          onMapReady: _moveToUserPosition,
          mapController: _controller,
          children: [
            SateliteImageOverlay(opacityNotifier: _opacityNotifier),
            const RegionBorder(),
            const SafeArea(child: CircularBackButton()),
            UserPositionIndicator(userLocation: _userLocation),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocSelector<SettingsCubit, SettingsState, bool>(
                selector: (state) =>
                    state is SettingsLoaded ? state.isMetric : true,
                builder: (context, isMetric) {
                  return BlocBuilder<SateliteCubit, SateliteState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichAttributionWidget(
                            showFlutterMapAttribution: false,
                            attributions: [
                              TextSourceAttribution(
                                Strings.of(context).mapTileAttribution,
                              ),
                            ],
                          ),
                          ProductMenu(
                            legend: SateliteTempLegend(),
                            legendUnit: isMetric ? '°C' : '°F',
                            time: (index) {
                              if (state is SateliteLoaded) {
                                return state.images[index].time;
                              }

                              return null;
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
