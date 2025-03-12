import 'package:flutter/material.dart';

import '../localization/l10n/generated/strings.dart';

enum WeatherType {
  clearSkies,
  partlyCloudy,
  mostlyCloudy,
  overcast,
  haze,
  smoke,
  fog,
  lightRain,
  rain,
  heavyRain,
  isolatedShower,
  severeThunderStorm,
  ;

  factory WeatherType.formCode(int code) {
    switch (code) {
      case 0:
        return WeatherType.clearSkies;
      case 1:
      case 2:
        return WeatherType.partlyCloudy;
      case 3:
        return WeatherType.mostlyCloudy;
      case 4:
        return WeatherType.overcast;
      case 5:
        return WeatherType.haze;
      case 10:
        return WeatherType.smoke;
      case 45:
        return WeatherType.fog;
      case 60:
        return WeatherType.lightRain;
      case 61:
        return WeatherType.rain;
      case 63:
        return WeatherType.heavyRain;
      case 80:
        return WeatherType.isolatedShower;
      case 95:
      case 97:
        return WeatherType.severeThunderStorm;
      default:
        return WeatherType.clearSkies;
    }
  }
}

extension WeatherCodeExtension on WeatherType {
  String get iconPathDay {
    return switch (this) {
      WeatherType.clearSkies => "assets/icon/sunny.png",
      WeatherType.partlyCloudy => "assets/icon/partly_cloudy.png",
      WeatherType.mostlyCloudy => "assets/icon/cloudy.png",
      WeatherType.overcast => "assets/icon/day_overcast.png",
      WeatherType.haze => "assets/icon/haze_day.png",
      WeatherType.smoke => "assets/icon/fog.png",
      WeatherType.fog => "assets/icon/fog.png",
      WeatherType.lightRain => "assets/icon/light_rain.png",
      WeatherType.rain => "assets/icon/rain.png",
      WeatherType.heavyRain => "assets/icon/heavy_rain.png",
      WeatherType.isolatedShower => "assets/icon/shower_rain.png",
      WeatherType.severeThunderStorm => "assets/icon/thunderstorm.png",
    };
  }

  String get iconPathNight {
    return switch (this) {
      WeatherType.clearSkies => "assets/icon/clear_night.png",
      WeatherType.partlyCloudy => "assets/icon/few_clouds_night.png",
      WeatherType.mostlyCloudy => "assets/icon/cloudy_night.png",
      WeatherType.overcast => "assets/icon/day_overcast.png",
      WeatherType.haze => "assets/icon/haze_day.png",
      WeatherType.smoke => "assets/icon/fog.png",
      WeatherType.fog => "assets/icon/fog.png",
      WeatherType.lightRain => "assets/icon/light_rain.png",
      WeatherType.rain => "assets/icon/rain.png",
      WeatherType.heavyRain => "assets/icon/heavy_rain.png",
      WeatherType.isolatedShower => "assets/icon/shower_rain.png",
      WeatherType.severeThunderStorm => "assets/icon/thunderstorm.png",
    };
  }

  String name(BuildContext context) {
    switch (this) {
      case WeatherType.clearSkies:
        return Strings.of(context).wtrClearSkies;
      case WeatherType.partlyCloudy:
        return Strings.of(context).wtrPartlyCloudy;
      case WeatherType.mostlyCloudy:
        return Strings.of(context).wtrMostlyCloudy;
      case WeatherType.overcast:
        return Strings.of(context).wtrOvercast;
      case WeatherType.haze:
        return Strings.of(context).wtrHaze;
      case WeatherType.smoke:
        return Strings.of(context).wtrSmoke;
      case WeatherType.fog:
        return Strings.of(context).wtrFog;
      case WeatherType.lightRain:
        return Strings.of(context).wtrLightRain;
      case WeatherType.rain:
        return Strings.of(context).wtrRain;
      case WeatherType.heavyRain:
        return Strings.of(context).wtrHeavyRain;
      case WeatherType.isolatedShower:
        return Strings.of(context).wtrIsolatedShower;
      case WeatherType.severeThunderStorm:
        return Strings.of(context).wtrSevereThunderStorm;
    }
  }
}
