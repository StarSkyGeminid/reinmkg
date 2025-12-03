import '../entities/maritime_weather_entity.dart';
import '../repositories/maritime_weather_repository.dart';

class GetMaritimeWeatherDetailUsecase {
  final MaritimeWeatherRepository repository;

  GetMaritimeWeatherDetailUsecase(this.repository);

  Future<List<MaritimeWeatherEntity>> call(String areaId) {
    return repository.getWeatherDetails(areaId);
  }
}
