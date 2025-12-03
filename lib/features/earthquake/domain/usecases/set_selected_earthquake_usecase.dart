import '../entities/earthquake_entity.dart';
import '../repositories/earthquake_repository.dart';

class SetSelectedEarthquake {
  final EarthquakeRepository repository;

  SetSelectedEarthquake(this.repository);

  void call(EarthquakeEntity entity) {
    repository.setSelectedEarthquake(entity);
  }
}
