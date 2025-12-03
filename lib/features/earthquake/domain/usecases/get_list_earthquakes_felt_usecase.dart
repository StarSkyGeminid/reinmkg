import '../entities/earthquake_entity.dart';
import '../repositories/earthquake_repository.dart';

class GetListEarthquakesFelt {
  final EarthquakeRepository repository;

  GetListEarthquakesFelt(this.repository);

  Future<List<EarthquakeEntity>> call() async {
    return repository.getListEarthquakesFelt();
  }
}
