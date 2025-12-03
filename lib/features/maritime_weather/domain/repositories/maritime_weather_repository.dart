import '../entities/maritime_weather_entity.dart';
import '../entities/water_wave_entity.dart';

abstract class MaritimeWeatherRepository {
  Future<List<WaterWaveEntity>> getWaterWaves();

  Future<List<MaritimeWeatherEntity>> getWeatherDetails(String areaId);
}
