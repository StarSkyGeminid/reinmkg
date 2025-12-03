import '../repositories/geojson_data_repository.dart';

class GetRegionBorderUsecase {
  final GeojsonDataRepository repository;

  GetRegionBorderUsecase(this.repository);

  Future<String> call() async {
    return await repository.getRegionBorder();
  }
}
