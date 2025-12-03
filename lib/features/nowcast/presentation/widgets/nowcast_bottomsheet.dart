import 'package:flutter/material.dart';

import '../../domain/entities/weather_nowcast_entity.dart';
import 'nowcast_warning_detail.dart';

class NowcastBottomsheet extends StatefulWidget {
  const NowcastBottomsheet({
    super.key,
    required this.draggableScrollableController,
    required this.nowcast,
  });

  final DraggableScrollableController draggableScrollableController;
  final WeatherNowcastEntity nowcast;

  @override
  State<NowcastBottomsheet> createState() => _NowcastBottomsheetState();
}

class _NowcastBottomsheetState extends State<NowcastBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.4,
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
          child: NowcastWarningDetail(
            scrollController: controller,
            nowcast: widget.nowcast,
          ),
        );
      },
    );
  }
}
