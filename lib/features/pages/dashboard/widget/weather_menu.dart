import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/app_route.dart';
import '../../../../core/localization/l10n/generated/strings.dart';
import 'weather_menu_item.dart';

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
        name: Strings.of(context).radar,
        path: Routes.radar.path,
        icon: Symbols.radar_rounded,
      ),
      WeatherMenuType(
        name: Strings.of(context).sateliteImage,
        path: Routes.satelite.path,
        icon: Symbols.satellite_alt_rounded,
      ),
      WeatherMenuType(
        name: Strings.of(context).nowcast,
        path: Routes.nowcast.path,
        icon: Symbols.cloud_alert_rounded,
      ),
      WeatherMenuType(
        name: Strings.of(context).maritime,
        path: Routes.maritimeWeather.path,
        icon: Symbols.sailing_rounded,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.01),
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 10 / 11,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: listWeatherMenus?.map((e) {
              return WeatherMenuItem(menu: e);
            }).toList() ??
            [],
      ),
    );
  }
}
