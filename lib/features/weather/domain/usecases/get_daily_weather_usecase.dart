import '../entities/entities.dart';
import '../repositories/repositories.dart';

class GetDailyWeatherUsecase {
  final WeatherRepository repository;

  GetDailyWeatherUsecase(this.repository);

  Future<List<DailyWeatherEntity>> call(String locationId) async {
    return repository.getDailyWeathers(locationId);
  }
}
