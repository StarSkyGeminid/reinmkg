import '../entities/weather_nowcast_entity.dart';

abstract class NowcastRepository {
  Future<List<WeatherNowcastEntity>> getNowcasts();
}
