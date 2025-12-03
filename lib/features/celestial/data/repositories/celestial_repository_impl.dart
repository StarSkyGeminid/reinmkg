import '../../domain/entities/celestial_entity.dart';
import '../../domain/repositories/celestial_repository.dart';
import '../datasources/local/local_celestial_service.dart';

class CelestialRepositoryImpl implements CelestialRepository {
  final LocalCelestialService _localCelestialService;

  CelestialRepositoryImpl(this._localCelestialService);

  @override
  Future<CelestialEntity> getCelestialData(DateTime dateTime, double latitude, double longitude) {
    return _localCelestialService.getCelestialData(dateTime, latitude, longitude);
  }
}
