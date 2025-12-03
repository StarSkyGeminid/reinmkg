import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/core/router.dart';

import 'weather_menu_item.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';

class WeatherMenu extends StatefulWidget {
  const WeatherMenu({super.key});

  @override
  State<WeatherMenu> createState() => _WeatherMenuState();
}

class _WeatherMenuState extends State<WeatherMenu> {
  List<WeatherMenuType>? listWeatherMenus;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (listWeatherMenus != null) return;

    listWeatherMenus = [
      WeatherMenuType(
        name: Strings.of(context).radarLabel,
        pathName: Routes.radar.name,
        icon: Symbols.radar_rounded,
      ),
      WeatherMenuType(
        name: Strings.of(context).satelliteLabel,
        pathName: Routes.satelite.name,
        icon: Symbols.satellite_alt_rounded,
      ),
      WeatherMenuType(
        name: Strings.of(context).nowcastLabel,
        pathName: Routes.nowcast.name,
        icon: Symbols.cloud_alert_rounded,
      ),
      WeatherMenuType(
        name: Strings.of(context).maritimeLabel,
        pathName: Routes.maritimeWeather.name,
        icon: Symbols.sailing_rounded,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.01),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 10 / 11,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children:
            listWeatherMenus?.map((e) {
              return WeatherMenuItem(menu: e);
            }).toList() ??
            [],
      ),
    );
  }
}
