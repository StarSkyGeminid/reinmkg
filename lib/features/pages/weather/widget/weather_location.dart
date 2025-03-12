import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../cubit/location/location_cubit.dart';

class WeatherLocation extends StatefulWidget {
  const WeatherLocation({super.key});

  @override
  State<WeatherLocation> createState() => WeatherLocationState();
}

class WeatherLocationState extends State<WeatherLocation> {
  @override
  Widget build(BuildContext context) {
    return _buildLocationInfo();
  }

  Widget _buildLocationInfo() {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return RichText(
          text: TextSpan(children: [
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Symbols.location_on_rounded,
                ),
              ),
            ),
            TextSpan(
              text: state.location?.subdistrict ?? '-',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ]),
        );
      },
    );
  }
}
