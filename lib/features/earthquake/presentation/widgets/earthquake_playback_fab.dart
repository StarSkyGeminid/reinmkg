import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';
import 'package:reinmkg/core/router.dart';

import '../cubit/selectable_earthquake/selectable_earthquake_cubit.dart';

class EarthquakePlaybackFab extends StatelessWidget {
  final DraggableScrollableController draggableScrollableController;
  final ValueNotifier<double> bottomSheetHeightNotifier;
  final Animation<Offset> fabOffset;
  final AnimationController fabController;

  const EarthquakePlaybackFab({
    super.key,
    required this.draggableScrollableController,
    required this.bottomSheetHeightNotifier,
    required this.fabOffset,
    required this.fabController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectableEarthquakeCubit, SelectableEarthquakeState>(
      builder: (context, state) {
        final earthquake = state is SelectableEarthquakeSelected
            ? state.earthquake
            : null;

        return ValueListenableBuilder<double>(
          valueListenable: bottomSheetHeightNotifier,
          builder: (context, value, child) {
            final isHidden =
                draggableScrollableController.isAttached &&
                draggableScrollableController.size >= 0.4;

            final visible =
                earthquake != null && earthquake.isFelt && !isHidden;

            return Positioned(
              bottom: value + 16,
              right: 16,
              child: SlideTransition(
                position: fabOffset,
                child: Visibility(
                  visible:
                      visible ||
                      fabController.status != AnimationStatus.dismissed,
                  maintainState: true,
                  child: InkWell(
                    onTap: () {
                      if (earthquake?.id == null || earthquake!.id!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              Strings.of(context).eventIdNotAvailable,
                            ),
                          ),
                        );
                        return;
                      }

                      Map<String, dynamic> extra = {
                        'time': earthquake.time,
                        'eventId': earthquake.id,
                        'latitude': earthquake.point?.latitude,
                        'longitude': earthquake.point?.longitude,
                        'magnitude': earthquake.magnitude,
                      };
                      GoRouter.of(
                        context,
                      ).push(Routes.seismicPlayback.path, extra: extra);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.shadow,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.play_arrow),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
