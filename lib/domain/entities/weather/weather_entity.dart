import 'package:equatable/equatable.dart';
import 'package:reinmkg/core/enumerate/weather_code.dart';

import '../../../core/enumerate/wind_direction.dart';

class WeatherEntity extends Equatable {
  final DateTime? time;
  final int? weather;
  final double? humidity;
  final double? temperature;
  // Cloud Cover in %
  final double? tcc;
  final double? visibility;
  final int? windDegree;
  final WindDirection? windDirection;
  final double? windSpeed;

  const WeatherEntity({
    this.time,
    this.weather = 0,
    this.humidity,
    this.temperature,
    this.tcc,
    this.visibility,
    this.windDegree,
    this.windDirection,
    this.windSpeed,
  });

  @override
  List<Object?> get props => [
        time,
        weather,
        humidity,
        temperature,
        tcc,
        visibility,
        windDegree,
        windDirection,
        windSpeed,
      ];

  WeatherType? get weatherCode =>
      weather != null ? WeatherType.formCode(weather!) : null;
}
