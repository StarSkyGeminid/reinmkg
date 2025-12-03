import '../entities/celestial_entity.dart';

abstract class CelestialRepository {
  Future<CelestialEntity> getCelestialData(DateTime dateTime, double latitude, double longitude);
}
