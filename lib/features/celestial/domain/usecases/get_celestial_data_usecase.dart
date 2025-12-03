import '../repositories/celestial_repository.dart';
import '../entities/celestial_entity.dart';

class GetCelestialDataUsecase {
  final CelestialRepository repository;

  GetCelestialDataUsecase(this.repository);

  Future<CelestialEntity> call(DateTime dateTime, double latitude, double longitude) async {
    return await repository.getCelestialData(dateTime, latitude, longitude);
  }
}
