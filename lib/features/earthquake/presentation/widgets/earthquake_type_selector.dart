import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';

import '../../domain/enumerates/earthquakes_type.dart';

class EarthquakeTypeSelector extends StatefulWidget {
  const EarthquakeTypeSelector({
    super.key,
    required this.onChanged,
    required this.selectedIndex,
  });

  final void Function(int) onChanged;
  final int selectedIndex;

  @override
  State<EarthquakeTypeSelector> createState() => _EarthquakeTypeSelectorState();
}

class _EarthquakeTypeSelectorState extends State<EarthquakeTypeSelector> {
  final ScrollController _controller = ScrollController();

  final List<String> viewType = ['map'];

  @override
  void initState() {
    super.initState();

    viewType.addAll(EarthquakesType.values.map((e) => e.name));
  }

  void onSelectionChanged(int index) {
    setState(() {
      widget.onChanged(index);
    });
  }

  @override
  void didUpdateWidget(EarthquakeTypeSelector oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedIndex == 0) {
      _controller.jumpTo(0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 200),
      height: 30,
      width: 0.6,
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.center,
            tileMode: TileMode.mirror,
            colors: [Theme.of(context).colorScheme.surface, Colors.transparent],
            stops: const [0.0, 0.2],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: ListView.builder(
          key: const PageStorageKey<String>('earthquake_history_selector'),
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          itemCount: viewType.length,
          controller: _controller,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: _buildButton(index, context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildButton(int index, BuildContext context) {
    return widget.selectedIndex == index
        ? ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: _button(index, context),
            ),
          )
        : _button(index, context);
  }

  ElevatedButton _button(int index, BuildContext context) {
    return ElevatedButton(
      onPressed: () => onSelectionChanged(index),
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.selectedIndex == index
            ? Colors.white.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.1),
        side: BorderSide(
          width: 1,
          color: widget.selectedIndex == index
              ? Colors.white
              : Colors.white.withValues(alpha: 0.1),
        ),
        textStyle: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
        overlayColor: Colors.white,
      ),
      child: Text(
        index == 0
            ? viewType[index].toUpperCase()
            : Strings.of(context).eqType(viewType[index]).toUpperCase(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: widget.selectedIndex == index
              ? Colors.white
              : Colors.white.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}
