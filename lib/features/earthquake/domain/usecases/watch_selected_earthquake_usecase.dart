import '../entities/earthquake_entity.dart';
import '../repositories/earthquake_repository.dart';

class WatchSelectedEarthquake {
  final EarthquakeRepository repository;

  WatchSelectedEarthquake(this.repository);

  Stream<EarthquakeEntity> call() {
    return repository.watchSelectedEarthquake();
  }
}
