import 'package:flutter/material.dart';

import 'maritime_weather_details.dart';

class MaritimeWeatherDetailsBottomSheet extends StatefulWidget {
  const MaritimeWeatherDetailsBottomSheet({
    super.key,
    required this.draggableScrollableController,
    this.selectedDay = 0,
  });

  final DraggableScrollableController draggableScrollableController;
  final int selectedDay;

  @override
  State<MaritimeWeatherDetailsBottomSheet> createState() =>
      _MaritimeWeatherDetailsBottomSheetState();
}

class _MaritimeWeatherDetailsBottomSheetState
    extends State<MaritimeWeatherDetailsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.4,
      maxChildSize: 0.7,
      controller: widget.draggableScrollableController,
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
          child: MaritimeWeatherDetails(
            scrollController: controller,
            selectedDay: widget.selectedDay,
          ),
        );
      },
    );
  }
}
