import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class WeatherLocation extends StatelessWidget {
  const WeatherLocation({super.key, this.locationName});

  final String? locationName;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Symbols.location_on_rounded),
            ),
          ),
          TextSpan(
            text: locationName ?? '-',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
