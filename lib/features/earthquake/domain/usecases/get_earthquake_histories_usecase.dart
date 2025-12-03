import '../entities/earthquake_entity.dart';
import '../repositories/earthquake_repository.dart';

class GetEarthquakeHistories {
  final EarthquakeRepository repository;

  GetEarthquakeHistories(this.repository);

  Future<List<EarthquakeEntity>> call() async {
    return repository.getEarthquakeHistories();
  }
}
