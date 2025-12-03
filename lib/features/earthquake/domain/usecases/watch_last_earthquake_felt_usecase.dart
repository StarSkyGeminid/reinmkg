import '../entities/earthquake_entity.dart';
import '../repositories/earthquake_repository.dart';

class WatchLastEarthquakeFelt {
  final EarthquakeRepository repository;

  WatchLastEarthquakeFelt(this.repository);

  Stream<EarthquakeEntity> call() {
    return repository.watchLastEarthquakeFelt();
  }
}
