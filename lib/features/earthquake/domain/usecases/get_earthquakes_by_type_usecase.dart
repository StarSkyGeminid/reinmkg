import '../entities/earthquake_entity.dart';
import '../enumerates/earthquakes_type.dart';
import '../repositories/earthquake_repository.dart';

class GetEarthquakesByType {
  final EarthquakeRepository repository;

  GetEarthquakesByType(this.repository);

  Future<List<EarthquakeEntity>> call(EarthquakesType type) async {
    return repository.getEarthquakesByType(type);
  }
}
