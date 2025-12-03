import 'package:equatable/equatable.dart';
import 'package:reinmkg/core/shared/domain/enumerate/weather_type.dart';

class DailyWeatherEntity extends Equatable {
  final DateTime? time;
  final int? weather;
  final int? maxTemp;
  final int? minTemp;

  const DailyWeatherEntity({
    this.time,
    this.weather,
    this.maxTemp,
    this.minTemp,
  });

  WeatherType? get weatherCode =>
      weather != null ? WeatherType.formCode(weather!) : null;

  @override
  List<Object?> get props {
    return [time, weather, maxTemp, minTemp];
  }
}
