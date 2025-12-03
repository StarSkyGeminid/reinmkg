import '../entities/location_entity.dart';
import '../repositories/location_repository.dart';

class RefreshLocationUsecase {
  final LocationRepository repository;

  RefreshLocationUsecase(this.repository);

  Future<LocationEntity> call() {
    return repository.refreshLocation();
  }
}
