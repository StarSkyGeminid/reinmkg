import 'package:froom/froom.dart';
import 'package:reinmkg/core/shared/domain/enumerate/wind_direction.dart';

import '../../domain/entities/weather_entity.dart';

extension on String {
  WindDirection? toWindDirection() {
    switch (toUpperCase()) {
      case 'N':
        return WindDirection.north;
      case 'NE':
        return WindDirection.northEast;
      case 'E':
        return WindDirection.east;
      case 'SE':
        return WindDirection.southEast;
      case 'S':
        return WindDirection.south;
      case 'SW':
        return WindDirection.southWest;
      case 'W':
        return WindDirection.west;
      case 'NW':
        return WindDirection.northWest;
      default:
        return null;
    }
  }
}

@Entity(tableName: 'weather', primaryKeys: ['time'])
class WeatherModel extends WeatherEntity {
  const WeatherModel({
    super.time,
    super.weather = 0,
    super.humidity,
    super.temperature,
    super.tcc,
    super.visibility,
    super.windDegree,
    super.windDirection,
    super.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> map) {
    return WeatherModel(
      time: map['datetime'] != null
          ? DateTime.parse(
              map['datetime'] ?? (map['utc_datetime'] + 'Z'),
            ).toLocal()
          : DateTime.now(),
      weather: map['weather'],
      humidity: map['hu'] is int
          ? (map['hu'] as int).toDouble()
          : double.tryParse(map['hu'].toString()),
      temperature: map['t'] is int
          ? (map['t'] as int).toDouble()
          : double.tryParse(map['t'].toString()),
      tcc: map['tcc'] is int
          ? (map['tcc'] as int).toDouble()
          : double.tryParse(map['tcc'].toString()),
      visibility: map['vs'] is int
          ? (map['vs'] as int).toDouble()
          : double.tryParse(map['vs'].toString()),
      windDegree: map['wd_deg'],
      windDirection: (map['wd'] as String?)?.toWindDirection(),
      windSpeed: map['ws'] is int
          ? (map['ws'] as int).toDouble()
          : double.tryParse(map['ws'].toString()),
    );
  }

  factory WeatherModel.fromEntity(WeatherEntity entity) {
    return WeatherModel(
      time: entity.time,
      weather: entity.weather,
      humidity: entity.humidity,
      temperature: entity.temperature,
      tcc: entity.tcc,
      visibility: entity.visibility,
      windDegree: entity.windDegree,
      windDirection: entity.windDirection,
      windSpeed: entity.windSpeed,
    );
  }

  WeatherEntity get toEntity {
    return WeatherEntity(
      time: time,
      weather: weather,
      humidity: humidity,
      temperature: temperature,
      tcc: tcc,
      visibility: visibility,
      windDegree: windDegree,
      windDirection: windDirection,
      windSpeed: windSpeed,
    );
  }

  WeatherModel copyWith({
    DateTime? time,
    int? weather,
    double? humidity,
    double? temperature,
    double? tcc,
    double? visibility,
    int? windDegree,
    WindDirection? windDirection,
    double? windSpeed,
  }) {
    return WeatherModel(
      time: time ?? this.time,
      weather: weather ?? this.weather,
      humidity: humidity ?? this.humidity,
      temperature: temperature ?? this.temperature,
      tcc: tcc ?? this.tcc,
      visibility: visibility ?? this.visibility,
      windDegree: windDegree ?? this.windDegree,
      windDirection: windDirection ?? this.windDirection,
      windSpeed: windSpeed ?? this.windSpeed,
    );
  }
}
