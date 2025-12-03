import '../entities/water_wave_entity.dart';
import '../repositories/maritime_weather_repository.dart';

class GetWaterWavesUsecase {
  final MaritimeWeatherRepository repository;

  GetWaterWavesUsecase(this.repository);

  Future<List<WaterWaveEntity>> call() {
    return repository.getWaterWaves();
  }
}
