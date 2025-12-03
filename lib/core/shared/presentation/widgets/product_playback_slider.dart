import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reinmkg/core/shared/presentation/cubits/cubits/playback_cubit.dart';

class ProductPlaybackSlider extends StatelessWidget {
  const ProductPlaybackSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.grey.shade300,
        inactiveTrackColor: Colors.grey,
        trackHeight: 1.0,
        thumbColor: Theme.of(context).colorScheme.primary,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
        overlayColor: Colors.grey,
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
      ),
      child: BlocBuilder<PlaybackCubit, PlaybackState>(
        builder: (context, state) {
          final maxIndex = BlocProvider.of<PlaybackCubit>(context).maxIndex;

          return Slider(
            value: state.index.toDouble(),
            max: maxIndex.toDouble(),
            divisions: maxIndex,
            onChanged: (double value) {
              BlocProvider.of<PlaybackCubit>(context).setIndex(value.toInt());
            },
          );
        },
      ),
    );
  }
}
