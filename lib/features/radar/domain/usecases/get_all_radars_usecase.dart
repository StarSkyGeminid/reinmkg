import '../entities/radar_entity.dart';
import '../repositories/radar_repository.dart';

class GetAllRadarsUsecase {
  RadarRepository repository;

  GetAllRadarsUsecase(this.repository);

  Future<List<RadarEntity>> call() {
    return repository.getAll();
  }
}
