import '../entities/earthquake_entity.dart';
import '../repositories/earthquake_repository.dart';

class GetLastEarthquakeFelt {
  final EarthquakeRepository repository;

  GetLastEarthquakeFelt(this.repository);

  Future<EarthquakeEntity> call() async {
    return repository.getLastEarthquakeFelt();
  }
}
