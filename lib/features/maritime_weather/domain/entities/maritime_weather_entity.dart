import 'package:equatable/equatable.dart';
import 'package:reinmkg/core/shared/domain/enumerate/weather_type.dart';
import 'package:reinmkg/core/shared/domain/enumerate/wind_direction.dart';
import 'package:reinmkg/core/shared/features/geojson_data/domain/enumerate/wave_height.dart';

class MaritimeWeatherEntity extends Equatable {
  final DateTime? validFrom;
  final DateTime? validTo;
  final WeatherType? weather;
  final String? weatherDesc;
  final String? warningDesc;
  final WaveHeight? waveHeight;
  final WindDirection? windFrom;
  final WindDirection? windTo;
  final int? windSpeedMin;
  final int? windSpeedMax;

  const MaritimeWeatherEntity({
    this.validFrom,
    this.validTo,
    this.weather,
    this.weatherDesc,
    this.warningDesc,
    this.waveHeight,
    this.windFrom,
    this.windTo,
    this.windSpeedMin,
    this.windSpeedMax,
  });

  @override
  List<Object?> get props {
    return [
      validFrom,
      validTo,
      weather,
      weatherDesc,
      warningDesc,
      waveHeight,
      windFrom,
      windTo,
      windSpeedMin,
      windSpeedMax,
    ];
  }
}
