import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/core/dependencies_injection.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';
import 'package:reinmkg/core/shared/presentation/cubits/cubits/playback_cubit.dart';
import 'package:reinmkg/core/shared/presentation/widgets/base_map.dart';
import 'package:reinmkg/core/shared/presentation/widgets/circular_back_button.dart';
import 'package:reinmkg/core/shared/presentation/widgets/product_menu.dart';
import 'package:reinmkg/core/shared/presentation/widgets/user_position_indicator.dart';
import 'package:reinmkg/features/general/location/presentation/cubit/location_cubit.dart';
import 'package:reinmkg/features/general/settings/presentation/cubit/settings_cubit.dart';

import '../../domain/entities/radar_entity.dart';
import '../../domain/enumerate/radar_type.dart';
import '../cubit/cubit.dart';
import '../widgets/radar_image_overlay.dart';
import '../widgets/widgets.dart';

class RadarPage extends StatefulWidget {
  const RadarPage({super.key});

  @override
  State<RadarPage> createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> {
  final MapController _controller = MapController();

  bool isMapReady = false;

  final ValueNotifier<double> _opacityNotifier = ValueNotifier(1.0);
  final ValueNotifier<LatLng> _userLocation = ValueNotifier(
    const LatLng(-6.175307, 106.8249059),
  );

  String currentRadarCity = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialRadar();
    });
  }

  void _loadInitialRadar() {
    final state = BlocProvider.of<LocationCubit>(context).state;

    if (state is LocationLoaded) {
      final position = state.location.toLatLng();

      if (position != null) {
        BlocProvider.of<RadarSelectionCubit>(
          context,
        ).load(position.latitude, position.longitude);
      }
    }
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
    final state = context.read<LocationCubit>().state;

    if (state is LocationLoaded) {
      final position = state.location.toLatLng();

      if (position == null) return;

      _userLocation.value = position;
    }
  }

  Future<void> _onSearchRadar() async {
    final radar = await showDialog(
      context: context,
      builder: (_) {
        return BlocProvider<RadarListCubit>(
          create: (context) => sl()..load(),
          child: SearchRadarDialog(),
        );
      },
    );

    if (!mounted) return;

    if (radar != null && radar is RadarEntity) {
      BlocProvider.of<RadarSelectionCubit>(context).select(radar);
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
              final pos = state.location.toLatLng();

              if (pos != null) {
                context.read<RadarSelectionCubit>().load(
                  pos.latitude,
                  pos.longitude,
                );
              }
            }
          },
        ),
        BlocListener<RadarSelectionCubit, RadarSelectionState>(
          listenWhen: (previous, current) {
            if (current is! RadarSelectionLoaded) return false;
            if (previous is! RadarSelectionLoaded) return true;

            return previous.radar != current.radar ||
                previous.type != current.type ||
                previous.images != current.images;
          },
          listener: (context, state) {
            if (state is! RadarSelectionLoaded) return;

            BlocProvider.of<PlaybackCubit>(
              context,
            ).setMaxIndex(state.images.length);

            var radarLocationChanged = state.radar.city != currentRadarCity;
            var radarPositionChanged =
                (state.radar.position != null) && isMapReady;
            if (radarLocationChanged && radarPositionChanged) {
              _controller.move(state.radar.position!, 7);

              currentRadarCity = state.radar.city ?? '';
            }
          },
        ),
      ],
      child: Scaffold(
        body: BaseMap(
          onMapReady: _onMapReady,
          mapController: _controller,
          children: [
            RadarCircleOverlay(),
            RadarImageOverlay(opacityNotifier: _opacityNotifier),
            UserPositionIndicator(userLocation: _userLocation),
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircularBackButton(),
                    BlocBuilder<RadarSelectionCubit, RadarSelectionState>(
                      builder: (context, state) {
                        RadarEntity? selectedRadar;

                        if (state is RadarSelectionLoaded) {
                          selectedRadar = state.radar;
                        }

                        return RadarLocation(location: selectedRadar?.city);
                      },
                    ),
                    SearchRadarButton(onTap: _onSearchRadar),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocSelector<SettingsCubit, SettingsState, bool>(
                selector: (state) =>
                    state is SettingsLoaded ? state.isMetric : true,
                builder: (context, isMetric) {
                  return BlocBuilder<RadarSelectionCubit, RadarSelectionState>(
                    builder: (context, state) {
                      RadarType selectedType = RadarType.cmax;

                      if (state is RadarSelectionLoaded) {
                        selectedType = state.type;
                      }

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
                            productTypeDropdown: RadarTypeDropdown(
                              onChanged: (value) {
                                BlocProvider.of<RadarSelectionCubit>(
                                  context,
                                ).changeType(value);
                              },
                              selectedType: selectedType,
                            ),
                            legend: selectedType.unit.isDbz
                                ? RadarDbzLegend()
                                : RadarMmLegend(),
                            legendUnit: selectedType.unit.displayName(
                              isMetric: isMetric,
                            ),
                            time: (index) {
                              if (state is RadarSelectionLoaded) {
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
