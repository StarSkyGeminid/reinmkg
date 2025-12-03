import '../entities/earthquake_entity.dart';
import '../repositories/earthquake_repository.dart';

class WatchRecentEarthquake {
  final EarthquakeRepository repository;

  WatchRecentEarthquake(this.repository);

  Stream<EarthquakeEntity> call() {
    return repository.watchRecentEarthquake();
  }
}
