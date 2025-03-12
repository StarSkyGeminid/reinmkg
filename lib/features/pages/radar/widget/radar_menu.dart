import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/enumerate/radar_type.dart';
import '../../../../core/localization/l10n/generated/strings.dart';
import '../../../bloc/weather/selectable_radar_bloc/selectable_radar_bloc.dart';
import '../../../cubit/general/settings/settings_cubit.dart';
import 'widget.dart';

class RadarMenu extends StatefulWidget {
  const RadarMenu({super.key});

  @override
  State<RadarMenu> createState() => _RadarMenuState();
}

class _RadarMenuState extends State<RadarMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
              _radarProductType(),
            ],
          ),
          _dbzLegend(context),
        ],
      ),
    );
  }

  Widget _time(BuildContext context) {
    return BlocBuilder<SelectableRadarBloc, SelectableRadarState>(
      buildWhen: (previous, current) =>
          previous.selectedRadarImages != current.selectedRadarImages,
      builder: (context, state) {
        if (state.selectedRadarImages?.time == null) {
          return const Text('-');
        }

        return Text(
          DateFormat('yyyy-MM-dd HH:mm')
              .format(state.selectedRadarImages!.time!),
        );
      },
    );
  }

  Widget _dbzLegend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('dbz'),
        Expanded(
          child: Container(
            height: 40,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomPaint(
              painter: RadarDbzLegend(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _viewControler() {
    return Row(
      children: [
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.grey.shade300,
              inactiveTrackColor: Colors.grey,
              trackHeight: 1.0,
              thumbColor: Theme.of(context).colorScheme.primary,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
              overlayColor: Colors.grey,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
            ),
            child: BlocBuilder<SelectableRadarBloc, SelectableRadarState>(
              buildWhen: (previous, current) =>
                  previous.currentIndex != current.currentIndex,
              builder: (context, state) {
                return Slider(
                  value: (state.currentIndex).toDouble(),
                  max: (state.radarImages?.length ?? 1).toDouble(),
                  divisions: (state.radarImages?.length ?? 5) - 2,
                  onChanged: (double value) {
                    BlocProvider.of<SelectableRadarBloc>(context)
                        .add(SelectableRadarEvent.sliderChanged(value.toInt()));
                  },
                );
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                BlocProvider.of<SelectableRadarBloc>(context)
                    .add(const SelectableRadarEvent.previous());
              },
              borderRadius: BorderRadius.circular(20),
              child: const Icon(Symbols.skip_previous_rounded),
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<SelectableRadarBloc>(context)
                    .add(const SelectableRadarEvent.play());
              },
              borderRadius: BorderRadius.circular(20),
              child: BlocBuilder<SelectableRadarBloc, SelectableRadarState>(
                buildWhen: (previous, current) =>
                    previous.isPlaying != current.isPlaying,
                builder: (context, state) {
                  return Icon(
                    state.isPlaying
                        ? Symbols.pause_rounded
                        : Symbols.play_arrow_rounded,
                  );
                },
              ),
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<SelectableRadarBloc>(context)
                    .add(const SelectableRadarEvent.next());
              },
              borderRadius: BorderRadius.circular(20),
              child: const Icon(Symbols.skip_next_rounded),
            ),
          ],
        ),
      ],
    );
  }

  Widget _radarProductType() {
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
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: BlocBuilder<SelectableRadarBloc, SelectableRadarState>(
              buildWhen: (previous, current) => previous.type != current.type,
              builder: (context, state) {
                return ProjectStatusDropdown(
                  onChanged: (value) {
                    BlocProvider.of<SelectableRadarBloc>(context)
                        .add(SelectableRadarEvent.setRadarType(value));
                  },
                  selectedType: state.type,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectStatusDropdown extends StatefulWidget {
  const ProjectStatusDropdown({
    super.key,
    required this.onChanged,
    required this.selectedType,
  });

  final void Function(RadarType) onChanged;
  final RadarType selectedType;

  @override
  State<ProjectStatusDropdown> createState() => _ProjectStatusDropdownState();
}

class _ProjectStatusDropdownState extends State<ProjectStatusDropdown> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<RadarType>(
          isDense: true,
          isExpanded: false,
          alignment: AlignmentDirectional.centerStart,
          value: widget.selectedType,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          onChanged: (RadarType? value) {
            if (value == null) return;
            widget.onChanged(value);
          },
          borderRadius: BorderRadius.circular(8),
          items: RadarType.values
              .map<DropdownMenuItem<RadarType>>(
                (RadarType item) => DropdownMenuItem(
                  value: item,
                  child: SizedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              Strings.of(context).radarTypeName(
                                  BlocProvider.of<SettingsCubit>(context)
                                      .state
                                      .measurementUnit
                                      .name,
                                  item.name),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
          selectedItemBuilder: (BuildContext ctxt) {
            return RadarType.values.map<Widget>((item) {
              return Container(
                alignment: Alignment.centerRight,
                constraints: const BoxConstraints(minWidth: 50),
                child: Text(
                  Strings.of(context).radarTypeName(
                      BlocProvider.of<SettingsCubit>(context)
                          .state
                          .measurementUnit
                          .name,
                      item.name),
                ),
              );
            }).toList();
          },
          icon: Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Icon(
              Symbols.keyboard_arrow_down_rounded,
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withOpacity(0.45),
            ),
          ),
          iconSize: 24,
          underline: const SizedBox(),
        ),
      ),
    );
  }
}
