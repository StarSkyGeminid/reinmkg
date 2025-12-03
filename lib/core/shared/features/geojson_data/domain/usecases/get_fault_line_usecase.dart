import '../repositories/geojson_data_repository.dart';

class GetFaultLineUsecase {
  final GeojsonDataRepository repository;

  GetFaultLineUsecase(this.repository);

  Future<String> call() async {
    return await repository.getFaultLine();
  }
}
