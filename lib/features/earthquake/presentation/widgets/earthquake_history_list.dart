import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reinmkg/features/features.dart';

import 'earthquake_tile.dart';

class EarthquakeHistoryList extends StatefulWidget {
  const EarthquakeHistoryList({
    super.key,
    required this.earthquakesType,
    required this.onTap,
  });

  final EarthquakesType earthquakesType;
  final VoidCallback onTap;

  @override
  State<EarthquakeHistoryList> createState() => _EarthquakeHistoryListState();
}

class _EarthquakeHistoryListState extends State<EarthquakeHistoryList> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<EarthquakeHistoryByTypeCubit>(
        context,
      ).getEarthquakes(widget.earthquakesType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      EarthquakeHistoryByTypeCubit,
      EarthquakeHistoryByTypeState
    >(
      builder: (context, state) {
        if (state is EarthquakeHistoryByTypeLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        final items = state is EarthquakeHistoryByTypeLoaded
            ? state.earthquakes
            : <EarthquakeEntity>[];

        return Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: ShaderMask(
            shaderCallback: (Rect rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Colors.transparent,
                ],
                stops: const [0.0, 0.1],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    BlocProvider.of<SelectableEarthquakeCubit>(
                      context,
                    ).setSelected(items[index]);

                    widget.onTap();
                  },
                  child: EarthquakeTile(earthquake: items[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
