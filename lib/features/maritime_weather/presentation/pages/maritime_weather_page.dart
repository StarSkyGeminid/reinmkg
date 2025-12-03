import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';
import 'package:reinmkg/core/shared/features/geojson_data/presentation/widgets/maritime_segment_marker.dart';
import 'package:reinmkg/core/shared/features/geojson_data/presentation/models/maritime_wave_item.dart';
import 'package:reinmkg/core/shared/presentation/widgets/base_map.dart';
import 'package:reinmkg/core/shared/presentation/widgets/circular_back_button.dart';

import '../../../general/location/presentation/cubit/location_cubit.dart';
import '../cubit/maritime_weather/maritime_weather_cubit.dart';
import '../cubit/maritime_weather_detail/maritime_weather_detail_cubit.dart';
import '../widgets/maritime_weather_details_bottom_sheet.dart';

class MaritimeWeatherPage extends StatefulWidget {
  const MaritimeWeatherPage({super.key});

  @override
  State<MaritimeWeatherPage> createState() => _MaritimeWeatherPageState();
}

class _MaritimeWeatherPageState extends State<MaritimeWeatherPage> {
  final MapController _controller = MapController();
  ValueNotifier<int> selectedDayIndex = ValueNotifier(0);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? _bottomSheetController;

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
                _controller.move(pos, 6);
              }
            }
          },
        ),
        BlocListener<MaritimeWeatherDetailCubit, MaritimeWeatherDetailState>(
          listener: (context, state) async {
            if (state is! MaritimeWeatherDetailLoaded) return;

            final cubit = BlocProvider.of<MaritimeWeatherDetailCubit>(context);

            if (_bottomSheetController != null) {
              try {
                _bottomSheetController!.close();
              } catch (_) {}
              _bottomSheetController = null;
            }

            final sheetController = DraggableScrollableController();

            final sheet = _scaffoldKey.currentState?.showBottomSheet((context) {
              return BlocProvider.value(
                value: cubit,
                child: ValueListenableBuilder<int>(
                  valueListenable: selectedDayIndex,
                  builder: (context, selectedDay, child) {
                    return MaritimeWeatherDetailsBottomSheet(
                      draggableScrollableController: sheetController,
                      selectedDay: selectedDay,
                    );
                  },
                ),
              );
            });

            _bottomSheetController = sheet;

            _bottomSheetController?.closed.then((_) {
              _bottomSheetController = null;
            });
          },
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        body: BaseMap(
          mapController: _controller,
          onMapReady: _moveToUserPosition,
          children: [
            _buildSegment(),
            const SafeArea(child: CircularBackButton()),
            RichAttributionWidget(
              showFlutterMapAttribution: false,
              attributions: [
                TextSourceAttribution(Strings.of(context).mapTileAttribution),
              ],
            ),
            SafeArea(child: _dataOffset()),
          ],
        ),
      ),
    );
  }

  Container _dataOffset() {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 9, right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Material(
            color: Colors.transparent,
            child: ValueListenableBuilder<int>(
              valueListenable: selectedDayIndex,
              builder: (context, selectedDay, child) {
                var chips = List.generate(4, (index) {
                  final labels = [
                    Strings.of(context).maritimeDayLabelToday,
                    Strings.of(context).maritimeDayLabelHPlus(1),
                    Strings.of(context).maritimeDayLabelHPlus(2),
                    Strings.of(context).maritimeDayLabelHPlus(3),
                  ];
                  final label = (index >= 0 && index < labels.length)
                      ? labels[index]
                      : labels[0];
                  return Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: ChoiceChip(
                      label: Text(
                        label,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      selected: selectedDay == index,
                      onSelected: (s) {
                        if (s) {
                          selectedDayIndex.value = index;
                        }
                      },
                    ),
                  );
                });

                return Row(mainAxisSize: MainAxisSize.min, children: chips);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegment() {
    return BlocBuilder<MaritimeWeatherCubit, MaritimeWeatherState>(
      builder: (context, state) {
        if (state is MaritimeWeatherInitial ||
            state is MaritimeWeatherLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is MaritimeWeatherFailure) {
          return Center(
            child: Text(
              'Gagal memuat data cuaca maritim',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }

        var waterWaves = (state as MaritimeWeatherLoaded).waves
            .map(
              (e) => MaritimeWaveItem(
                id: e.id,
                today: e.today,
                h1: e.h1,
                h2: e.h2,
                h3: e.h3,
              ),
            )
            .toList();

        return ValueListenableBuilder<int>(
          valueListenable: selectedDayIndex,
          builder: (context, selectedDay, child) {
            return MaritimeSegmentMarker(
              waterWaves: waterWaves,
              selectedDay: selectedDay,
              onTap: (id) {
                BlocProvider.of<MaritimeWeatherDetailCubit>(
                  context,
                ).getDetails(id);
              },
            );
          },
        );
      },
    );
  }
}
