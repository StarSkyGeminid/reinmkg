import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../domain/enumerate/radar_type.dart';

class RadarTypeDropdown extends StatefulWidget {
  const RadarTypeDropdown({
    super.key,
    required this.onChanged,
    required this.selectedType,
  });

  final void Function(RadarType) onChanged;
  final RadarType selectedType;

  @override
  State<RadarTypeDropdown> createState() => _RadarTypeDropdownState();
}

class _RadarTypeDropdownState extends State<RadarTypeDropdown> {
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
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
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
                              item.displayName,
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
                child: Text(item.displayName),
              );
            }).toList();
          },
          icon: Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Icon(
              Symbols.keyboard_arrow_down_rounded,
              color: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withValues(alpha: 0.45),
            ),
          ),
          iconSize: 24,
          underline: const SizedBox(),
        ),
      ),
    );
  }
}
