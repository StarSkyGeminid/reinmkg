import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';

import '../../../data.dart';

abstract class RemoteWeatherService {
  Future<Either<Failure, WeatherModel>> getCurrentWeather(String locationId);

  Future<Either<Failure, List<WeatherModel>>> getWeeklyWeathers(
      String locationId);

  Future<Either<Failure, List<DailyWeatherModel>>> getDailyWeathers(
      String locationId);

  Future<Either<Failure, List<String>>> getSateliteImages();

  Future<Either<Failure, List<WaterWaveModel>>> getWaterWaves();
}
