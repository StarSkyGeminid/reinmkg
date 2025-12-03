import '../entities/location_entity.dart';
import '../repositories/location_repository.dart';

class GetCurrentLocationUsecase {
  LocationRepository repository;

  GetCurrentLocationUsecase(this.repository);

  Future<LocationEntity> call() {
    return repository.getCurrentLocation();
  }
}
