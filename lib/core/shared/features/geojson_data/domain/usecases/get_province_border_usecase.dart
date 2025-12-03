import '../repositories/geojson_data_repository.dart';

class GetProvinceBorderUsecase {
  final GeojsonDataRepository repository;

  GetProvinceBorderUsecase(this.repository);

  Future<String> call() async {
    return await repository.getProvinceBorder();
  }
}
