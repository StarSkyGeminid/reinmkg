import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/localization/l10n/generated/strings.dart';
import '../../../../domain/entities/earthquake/earthquake_entity.dart';
import '../../../bloc/earthquake/selectable_earthquake/selectable_earthquake_bloc.dart';
import '../../../cubit/general/settings/settings_cubit.dart';
import '../../../cubit/location/location_cubit.dart';
import 'widget.dart';

class EarthquakeDataBottomSheet extends StatefulWidget {
  const EarthquakeDataBottomSheet(
      {super.key, required this.draggableScrollableController});

  final DraggableScrollableController draggableScrollableController;

  @override
  State<EarthquakeDataBottomSheet> createState() =>
      _EarthquakeDataBottomSheetState();
}

class _EarthquakeDataBottomSheetState extends State<EarthquakeDataBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.18,
      controller: widget.draggableScrollableController,
      shouldCloseOnMinExtent: false,
      builder: (context, controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ListView(
            controller: controller,
            shrinkWrap: true,
            children: [
              const EarthquakeBasicData(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0).h,
                child: _earthquakeMainData(controller),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _earthquakeMainData(ScrollController scrollController) {
    return BlocBuilder<SelectableEarthquakeBloc, SelectableEarthquakeState>(
      builder: (context, state) {
        if (state.earthquake == null) {
          return const SizedBox.shrink();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _feltArea(state.earthquake!),
            _instruction(state.earthquake!),
            _coordinate(state.earthquake!),
            _description(state.earthquake!),
            _distance(state.earthquake!),
            if (state.earthquake?.shakemap != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0).h,
                child: ShakeMapView(
                  eventId: state.earthquake!.shakemap!,
                  dragableScrollableController:
                      widget.draggableScrollableController,
                  scrollController: scrollController,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _feltArea(EarthquakeEntity earthquake) {
    return _informationView(
        Strings.of(context).eqFeltArea, earthquake.felt, Iconsax.map);
  }

  Widget _coordinate(EarthquakeEntity earthquake) {
    return _informationView(Strings.of(context).coordinate,
        '${earthquake.latitude}, ${earthquake.longitude}', Iconsax.location);
  }

  Widget _description(EarthquakeEntity earthquake) {
    return _informationView(
        Strings.of(context).description, earthquake.area, Symbols.description);
  }

  Widget _instruction(EarthquakeEntity earthquake) {
    return _informationView(Strings.of(context).instruction,
        earthquake.instruction, Iconsax.info_circle);
  }

  Widget _distance(EarthquakeEntity earthquake) {
    const Distance distance = Distance();

    final currentLocation =
        BlocProvider.of<LocationCubit>(context).state.location;

    final userCoordinate = currentLocation?.toLatLng();

    var eqLocation = earthquake.point!.toLatLng();

    final isMetric =
        BlocProvider.of<SettingsCubit>(context).state.measurementUnit.isMetric;

    final km = userCoordinate != null && eqLocation != null
        ? distance.as(
            isMetric ? LengthUnit.Kilometer : LengthUnit.Mile,
            eqLocation,
            userCoordinate,
          )
        : null;

    final userDistance = km?.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]}.");

    return _informationView(
      Strings.of(context).distance,
      Strings.of(context).eqDistance(
        userDistance.toString(),
        isMetric.toString(),
        currentLocation?.subdistrict ?? '-',
        km ?? 0,
      ),
      Symbols.straighten,
    );
  }

  Widget _informationView(String title, String? value, IconData icon) {
    if (value == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0).h,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0).w,
            child: Icon(icon),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Flexible(child: Text(value)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
