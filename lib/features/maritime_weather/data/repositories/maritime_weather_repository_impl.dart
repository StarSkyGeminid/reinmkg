import 'package:reinmkg/features/maritime_weather/domain/entities/maritime_weather_entity.dart';

import '../../domain/entities/water_wave_entity.dart';
import '../../domain/repositories/maritime_weather_repository.dart';
import '../datasources/remote/remote_maritime_weather_service.dart';

class MaritimeWeatherRepositoryImpl implements MaritimeWeatherRepository {
  final RemoteMaritimeWeatherService _maritimeWeatherService;

  MaritimeWeatherRepositoryImpl(this._maritimeWeatherService);

  @override
  Future<List<WaterWaveEntity>> getWaterWaves() {
    return _maritimeWeatherService.getWaterWaves();
  }

  @override
  Future<List<MaritimeWeatherEntity>> getWeatherDetails(String areaId) {
    return _maritimeWeatherService.getWeatherDetails(areaId);
  }
}
