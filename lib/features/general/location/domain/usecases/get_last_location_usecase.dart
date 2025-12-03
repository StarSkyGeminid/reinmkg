import '../entities/location_entity.dart';
import '../repositories/location_repository.dart';

class GetLastLocationUsecase {
  LocationRepository repository;

  GetLastLocationUsecase(this.repository);

  Future<LocationEntity> call() {
    return repository.getLastLocation();
  }
}
