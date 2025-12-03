import '../repositories/geojson_data_repository.dart';

class GetMaritimeBoundariesUsecase {
  GeojsonDataRepository repository;

  GetMaritimeBoundariesUsecase(this.repository);

  Future<String> call() {
    return repository.getMaritimeBoundary();
  }
}
