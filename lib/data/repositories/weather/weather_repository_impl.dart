import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/error/failure.dart';
import 'package:reinmkg/core/network/network_info.dart';
import 'package:reinmkg/data/data.dart';

import '../../../domain/domain.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteWeatherService _remoteWeatherService;
  final LocalWeatherService _localWeatherService;
  final NetworkInfo _networkInfo;

  WeatherRepositoryImpl(
      this._remoteWeatherService, this._localWeatherService, this._networkInfo);

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String locationId) async {
    final isConnected = _networkInfo.isConnected;

    return isConnected
        ? _remoteWeatherService.getCurrentWeather(locationId)
        : _localWeatherService.getCurrentWeather();
  }

  @override
  Future<Either<Failure, List<WeatherEntity>>> getWeeklyWeathers(
      String locationId) async {
    final isConnected = _networkInfo.isConnected;

    final weathers = isConnected
        ? await _remoteWeatherService.getWeeklyWeathers(locationId)
        : await _localWeatherService.getWeeklyWeathers();

    final data = weathers.fold((l) => null, (r) => r);

    if (isConnected && data != null) {
      _localWeatherService.replaceWeathers(data);
    }

    return weathers;
  }

  @override
  Future<Either<Failure, List<DailyWeatherEntity>>> getDailyWeathers(
      String locationId) async {
    final isConnected = _networkInfo.isConnected;

    final weathers = isConnected
        ? await _remoteWeatherService.getDailyWeathers(locationId)
        : await _localWeatherService.getDailyWeathers();

    final data = weathers.fold((l) => null, (r) => r);

    if (isConnected && data != null) {
      _localWeatherService.replaceDailyWeathers(data);
    }

    return weathers;
  }

  @override
  Future<Either<Failure, List<String>>> getSateliteImages() async {
    if (_networkInfo.isConnected) {
      return _remoteWeatherService.getSateliteImages();
    }

    return Left(NoDataFailure());
  }

  @override
  Future<Either<Failure, List<WaterWaveEntity>>> getWaterWave() async {
    if (_networkInfo.isConnected) {
      return _remoteWeatherService.getWaterWaves();
    }

    return Left(NoDataFailure());
  }
}
