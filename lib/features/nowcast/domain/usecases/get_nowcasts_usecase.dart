import '../entities/weather_nowcast_entity.dart';
import '../repositories/nowcast_repository.dart';

class GetNowcastsUsecase {
  final NowcastRepository repository;

  GetNowcastsUsecase(this.repository);

  Future<List<WeatherNowcastEntity>> call() {
    return repository.getNowcasts();
  }
}
