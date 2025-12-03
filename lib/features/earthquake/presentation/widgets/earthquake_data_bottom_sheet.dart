import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';
import 'package:reinmkg/features/general/location/presentation/cubit/location_cubit.dart';
import 'package:reinmkg/features/general/settings/presentation/cubit/settings_cubit.dart';

import '../../domain/entities/earthquake_entity.dart';
import '../cubit/selectable_earthquake/selectable_earthquake_cubit.dart';
import 'widgets.dart';

class EarthquakeDataBottomSheet extends StatefulWidget {
  const EarthquakeDataBottomSheet({
    super.key,
    required this.draggableScrollableController,
  });

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
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
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
                padding: const EdgeInsets.only(top: 8.0),
                child: _earthquakeMainData(controller),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _earthquakeMainData(ScrollController scrollController) {
    return BlocBuilder<SelectableEarthquakeCubit, SelectableEarthquakeState>(
      builder: (context, state) {
        final earthquake = state is SelectableEarthquakeSelected
            ? state.earthquake
            : null;

        if (earthquake == null) return const SizedBox.shrink();

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _feltArea(earthquake),
            _instruction(earthquake),
            _coordinate(earthquake),
            _description(earthquake),
            TsunamiInfo(earthquake: earthquake),
            _distance(earthquake),
            if (earthquake.shakemap != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ShakeMapView(
                  eventId: earthquake.shakemap!,
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
      Strings.of(context).earthquakeFeltAreaLabel,
      earthquake.felt,
      Iconsax.map,
    );
  }

  Widget _coordinate(EarthquakeEntity earthquake) {
    return _informationView(
      Strings.of(context).coordinateLabel,
      '${earthquake.latitude}, ${earthquake.longitude}',
      Iconsax.location,
    );
  }

  Widget _description(EarthquakeEntity earthquake) {
    return _informationView(
      Strings.of(context).descriptionLabel,
      earthquake.area,
      Symbols.description,
    );
  }

  Widget _instruction(EarthquakeEntity earthquake) {
    return _informationView(
      Strings.of(context).instructionLabel,
      earthquake.instruction,
      Iconsax.info_circle,
    );
  }

  Widget _distance(EarthquakeEntity earthquake) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, locationState) {
        final settingsState = BlocProvider.of<SettingsCubit>(context).state;

        final isMetric = (settingsState is SettingsLoaded)
            ? settingsState.isMetric
            : true;

        if (locationState is LocationLoaded) {
          final distance = earthquake.distanceTo(
            locationState.location.latitude,
            locationState.location.longitude,
          );

          final subdistrict = locationState.location.subdistrict;

          final subdistrictText = subdistrict != null
              ? Strings.of(context).fromSubdistrict(subdistrict)
              : '';

          if (distance != null) {
            final convertedValue = isMetric ? distance : distance * 0.621371;
            final unit = isMetric
                ? Strings.of(context).unitKm
                : Strings.of(context).unitMiles;
            final formattedDisplay =
                '${convertedValue.toStringAsFixed(0)} $unit $subdistrictText';

            return _informationView(
              Strings.of(context).distanceLabel,
              formattedDisplay,
              Symbols.straighten,
            );
          }
        } else if (locationState is LocationLoading) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Symbols.straighten),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Strings.of(context).distanceLabel,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return _informationView(
          Strings.of(context).distanceLabel,
          '-',
          Symbols.straighten,
        );
      },
    );
  }

  Widget _informationView(String title, String? value, IconData icon) {
    if (value == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
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
