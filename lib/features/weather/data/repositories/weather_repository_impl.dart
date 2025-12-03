import 'package:reinmkg/features/weather/domain/entities/daily_weather_entity.dart';

import 'package:reinmkg/features/weather/domain/entities/weather_entity.dart';

import '../../domain/repositories/weather_repository.dart';
import '../datasources/datasources.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final LocalWeatherService _localWeatherService;
  final RemoteWeatherService _remoteWeatherService;

  WeatherRepositoryImpl(this._localWeatherService, this._remoteWeatherService);

  @override
  Future<WeatherEntity> getCurrentWeather(String locationId) async {
    try {
      return _remoteWeatherService.getCurrentWeather(locationId);
    } catch (e) {
      return _localWeatherService.getCurrentWeather();
    }
  }

  @override
  Future<List<DailyWeatherEntity>> getDailyWeathers(String locationId) async {
    try {
      final dailyWeathers = await _remoteWeatherService.getDailyWeather(
        locationId,
      );

      _localWeatherService.replaceDailyWeathers(dailyWeathers);

      return dailyWeathers;
    } catch (e) {
      return _localWeatherService.getDailyWeathers();
    }
  }

  @override
  Future<List<WeatherEntity>> getWeeklyWeathers(String locationId) async {
    try {
      final weeklyWeather = await _remoteWeatherService.getWeeklyWeather(
        locationId,
      );

      _localWeatherService.replaceWeathers(weeklyWeather);

      return weeklyWeather;
    } catch (e) {
      return _localWeatherService.getWeeklyWeathers();
    }
  }
}
