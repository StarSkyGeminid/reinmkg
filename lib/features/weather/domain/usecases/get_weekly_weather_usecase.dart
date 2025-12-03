import '../entities/entities.dart';
import '../repositories/repositories.dart';

class GetWeeklyWeatherUsecase {
  final WeatherRepository repository;

  GetWeeklyWeatherUsecase(this.repository);

  Future<List<WeatherEntity>> call(String locationId) async {
    return repository.getWeeklyWeathers(locationId);
  }
}
