import '../entities/weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeatherUsecase {
  final WeatherRepository repository;

  GetCurrentWeatherUsecase(this.repository);

  Future<WeatherEntity> call(String locationId) async {
    return repository.getCurrentWeather(locationId);
  }
}
