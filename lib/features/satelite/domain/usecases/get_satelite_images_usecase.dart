import '../entities/satelite_entity.dart';
import '../repositories/satelite_repository.dart';

class GetSateliteImagesUsecase {
  SateliteRepository repository;

  GetSateliteImagesUsecase(this.repository);

  Future<List<SateliteEntity>> call() {
    return repository.getSateliteImages();
  }
}
