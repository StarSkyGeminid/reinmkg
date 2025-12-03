import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/core/shared/presentation/cubits/cubits/playback_cubit.dart';
import 'package:reinmkg/core/utils/extension/datetime.dart';

import 'product_playback_slider.dart';

class ProductMenu extends StatefulWidget {
  const ProductMenu({
    super.key,
    this.productTypeDropdown,
    required this.legend,
    required this.legendUnit,
    this.time,
  });

  final Widget? productTypeDropdown;
  final Widget legend;
  final String legendUnit;
  final DateTime? Function(int index)? time;

  @override
  State<ProductMenu> createState() => _ProductMenuState();
}

class _ProductMenuState extends State<ProductMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _viewControler(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _time(context),
              if (widget.productTypeDropdown != null) _productType(),
            ],
          ),
          _legend(context),
        ],
      ),
    );
  }

  Widget _time(BuildContext context) {
    return BlocBuilder<PlaybackCubit, PlaybackState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        final date = widget.time?.call(state.index);

        if (date == null) {
          return Text('-');
        }

        return Flexible(
          child: Text(
            date.toDateTimeString(withSecond: false, withTimezone: true),
            maxLines: 2,
          ),
        );
      },
    );
  }

  Widget _legend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.legendUnit),
        Expanded(
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: widget.legend,
          ),
        ),
      ],
    );
  }

  Widget _viewControler() {
    return Row(
      children: [
        Expanded(child: ProductPlaybackSlider()),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                BlocProvider.of<PlaybackCubit>(context).previous();
              },
              borderRadius: BorderRadius.circular(20),
              child: const Icon(Symbols.skip_previous_rounded),
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<PlaybackCubit>(context).playPause();
              },
              borderRadius: BorderRadius.circular(20),
              child: BlocBuilder<PlaybackCubit, PlaybackState>(
                builder: (context, state) {
                  return Icon(
                    state.playing
                        ? Symbols.pause_rounded
                        : Symbols.play_arrow_rounded,
                  );
                },
              ),
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<PlaybackCubit>(context).next();
              },
              borderRadius: BorderRadius.circular(20),
              child: const Icon(Symbols.skip_next_rounded),
            ),
          ],
        ),
      ],
    );
  }

  Widget _productType() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Product'),
          Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(8),
            ),
            child: widget.productTypeDropdown,
          ),
        ],
      ),
    );
  }
}
