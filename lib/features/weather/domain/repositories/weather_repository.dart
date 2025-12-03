
import '../entities/entities.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getCurrentWeather(String locationId);

  Future<List<WeatherEntity>> getWeeklyWeathers(String locationId);

  Future<List<DailyWeatherEntity>> getDailyWeathers(String locationId);
}
