import '../entities/earthquake_entity.dart';
import '../repositories/earthquake_repository.dart';

class GetOneWeekEarthquakes {
  final EarthquakeRepository repository;

  GetOneWeekEarthquakes(this.repository);

  Future<List<EarthquakeEntity>> call() async {
    return repository.getOneWeekEarthquakes();
  }
}
