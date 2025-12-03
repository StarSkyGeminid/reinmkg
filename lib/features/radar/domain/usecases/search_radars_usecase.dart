import '../entities/entities.dart';
import '../repositories/radar_repository.dart';

class SearchRadarsUsecase {
  final RadarRepository repository;

  SearchRadarsUsecase(this.repository);

  Future<List<RadarEntity>> call(String query) {
    return repository.searchRadars(query);
  }
}
