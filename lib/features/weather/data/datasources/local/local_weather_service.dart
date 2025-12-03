import 'package:reinmkg/core/data/local/app_database.dart';

import '../../models/models.dart';

abstract class LocalWeatherService {
  Future<WeatherModel> getCurrentWeather();

  Future<List<WeatherModel>> getWeeklyWeathers();

  Future<List<DailyWeatherModel>> getDailyWeathers();

  Future<void> replaceWeathers(List<WeatherModel> listWeatherModel);

  Future<void> replaceDailyWeathers(List<DailyWeatherModel> listWeatherModel);
}

class LocalWeatherServiceImpl implements LocalWeatherService {
  final AppDatabase _appDatabase;

  LocalWeatherServiceImpl(this._appDatabase);

  @override
  Future<WeatherModel> getCurrentWeather() async {
    try {
      final weather = await _appDatabase.weatherDao.getCurrentWeather(
        _getNowSubtractedEpoch(),
      );

      if (weather == null) throw Exception('No cached data found');

      return weather;
    } catch (e) {
      throw Exception('Failed to retrieve current weather: $e');
    }
  }

  @override
  Future<List<DailyWeatherModel>> getDailyWeathers() async {
    try {
      final weathers = await _appDatabase.dailyWeatherDao.getDailyWeathers(
        _getNowSubtractedEpoch(),
      );

      if (weathers == null) throw Exception('No cached data found');

      return weathers;
    } catch (e) {
      throw Exception('Failed to retrieve daily weathers: $e');
    }
  }

  @override
  Future<List<WeatherModel>> getWeeklyWeathers() async {
    try {
      final weathers = await _appDatabase.weatherDao.getWeathers(
        _getNowSubtractedEpoch(),
      );

      if (weathers == null) throw Exception('No cached data found');

      return weathers;
    } catch (e) {
      throw Exception('Failed to retrieve weekly weathers: $e');
    }
  }

  @override
  Future<void> replaceWeathers(List<WeatherModel> listWeatherModel) async {
    return _appDatabase.weatherDao.deleteWeather().then((_) {
      return _appDatabase.weatherDao.insertWeathers(listWeatherModel);
    });
  }

  @override
  Future<void> replaceDailyWeathers(
    List<DailyWeatherModel> listDailyWeatherModel,
  ) async {
    return _appDatabase.dailyWeatherDao.deleteDailyWeather().then((_) {
      return _appDatabase.dailyWeatherDao.insertDailyWeathers(
        listDailyWeatherModel,
      );
    });
  }

  int _getNowSubtractedEpoch() {
    return DateTime.now()
        .subtract(const Duration(minutes: 59))
        .millisecondsSinceEpoch;
  }
}
