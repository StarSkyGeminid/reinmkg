import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';

import '../../domain.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String locationId);

  Future<Either<Failure, List<WeatherEntity>>> getWeeklyWeathers(
      String locationId);

  Future<Either<Failure, List<DailyWeatherEntity>>> getDailyWeathers(
      String locationId);

  Future<Either<Failure, List<String>>> getSateliteImages();

  Future<Either<Failure, List<WaterWaveEntity>>> getWaterWave();
}
