import '../entities/earthquake_entity.dart';
import '../repositories/earthquake_repository.dart';

class GetRecentEarthquake {
  final EarthquakeRepository repository;

  GetRecentEarthquake(this.repository);

  Future<EarthquakeEntity> call() async {
    return repository.getRecentEarthquake();
  }
}
