import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/core/shared/domain/enumerate/weather_type.dart';
import 'package:reinmkg/core/shared/domain/enumerate/wind_direction.dart';

import '../../domain/entities/maritime_weather_entity.dart';

extension on String {
  WindDirection? toWindDirection() {
    switch (toLowerCase()) {
      case 'utara':
        return WindDirection.north;
      case 'timur laut':
        return WindDirection.northEast;
      case 'timur':
        return WindDirection.east;
      case 'tenggara':
        return WindDirection.southEast;
      case 'selatan':
        return WindDirection.south;
      case 'barat daya':
        return WindDirection.southWest;
      case 'barat':
        return WindDirection.west;
      case 'barat laut':
        return WindDirection.northWest;
      default:
        return null;
    }
  }

  WeatherType? toWeatherType() {
    switch (toLowerCase()) {
      case 'cerah':
        return WeatherType.clearSkies;
      case 'cerah berawan':
        return WeatherType.partlyCloudy;
      case 'berawan':
        return WeatherType.mostlyCloudy;
      case 'hujan ringan':
        return WeatherType.lightRain;
      case 'hujan sedang':
        return WeatherType.rain;
      case 'hujan lebat':
      case 'sangat lebat':
        return WeatherType.heavyRain;
      case 'ekstrem':
        return WeatherType.severeThunderStorm;
      case 'berkabut':
        return WeatherType.fog;
      default:
        return null;
    }
  }

  WaveHeight? toWaveHeight() {
    switch (toLowerCase()) {
      case 'tenang':
        return WaveHeight.calm;
      case 'rendah':
        return WaveHeight.low;
      case 'sedang':
        return WaveHeight.medium;
      case 'tinggi':
        return WaveHeight.high;
      case 'sangat tinggi':
        return WaveHeight.veryHigh;
      case 'ekstrim':
      case 'ekstrem':
        return WaveHeight.extreme;
      default:
        return null;
    }
  }
}

class MaritimeWeatherModel extends MaritimeWeatherEntity {
  const MaritimeWeatherModel({
    super.validFrom,
    super.validTo,
    super.weather,
    super.weatherDesc,
    super.warningDesc,
    super.waveHeight,
    super.windFrom,
    super.windTo,
    super.windSpeedMin,
    super.windSpeedMax,
  });

  factory MaritimeWeatherModel.fromJson(Map<String, dynamic> map) {
    DateTime? tryParseDate(dynamic raw) {
      if (raw == null) return null;
      final s = raw.toString().trim();
      try {
        return DateTime.parse(s).toLocal();
      } catch (_) {
        var t = s;
        t = t.replaceFirst(RegExp(r"\s*UTC\s*", caseSensitive: false), 'Z');
        t = t.replaceFirst(' ', 'T');
        try {
          return DateTime.parse(t).toLocal();
        } catch (_) {
          return null;
        }
      }
    }

    return MaritimeWeatherModel(
      validFrom: tryParseDate(map['valid_from']),
      validTo: tryParseDate(map['valid_to']),
      weather: (map['weather'] as String?)?.toWeatherType(),
      weatherDesc: map['weather_desc'],
      warningDesc: map['warning_desc'],
      waveHeight: (map['wave_cat'] as String?)?.toWaveHeight(),
      windFrom: (map['wind_from'] as String?)?.toWindDirection(),
      windTo: (map['wind_to'] as String?)?.toWindDirection(),
      windSpeedMin: map['wind_speed_min'],
      windSpeedMax: map['wind_speed_max'],
    );
  }
}
