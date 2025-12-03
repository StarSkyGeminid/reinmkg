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
  severeThunderStorm;

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
      WeatherType.clearSkies => "lib/assets/icon/sunny.png",
      WeatherType.partlyCloudy => "lib/assets/icon/partly_cloudy.png",
      WeatherType.mostlyCloudy => "lib/assets/icon/cloudy.png",
      WeatherType.overcast => "lib/assets/icon/day_overcast.png",
      WeatherType.haze => "lib/assets/icon/haze_day.png",
      WeatherType.smoke => "lib/assets/icon/fog.png",
      WeatherType.fog => "lib/assets/icon/fog.png",
      WeatherType.lightRain => "lib/assets/icon/light_rain.png",
      WeatherType.rain => "lib/assets/icon/rain.png",
      WeatherType.heavyRain => "lib/assets/icon/heavy_rain.png",
      WeatherType.isolatedShower => "lib/assets/icon/shower_rain.png",
      WeatherType.severeThunderStorm => "lib/assets/icon/thunderstorm.png",
    };
  }

  String get iconPathNight {
    return switch (this) {
      WeatherType.clearSkies => "lib/assets/icon/clear_night.png",
      WeatherType.partlyCloudy => "lib/assets/icon/few_clouds_night.png",
      WeatherType.mostlyCloudy => "lib/assets/icon/cloudy_night.png",
      WeatherType.overcast => "lib/assets/icon/day_overcast.png",
      WeatherType.haze => "lib/assets/icon/haze_day.png",
      WeatherType.smoke => "lib/assets/icon/fog.png",
      WeatherType.fog => "lib/assets/icon/fog.png",
      WeatherType.lightRain => "lib/assets/icon/light_rain.png",
      WeatherType.rain => "lib/assets/icon/rain.png",
      WeatherType.heavyRain => "lib/assets/icon/heavy_rain.png",
      WeatherType.isolatedShower => "lib/assets/icon/shower_rain.png",
      WeatherType.severeThunderStorm => "lib/assets/icon/thunderstorm.png",
    };
  }
}
