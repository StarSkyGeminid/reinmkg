import '../entities/earthquake_pga_entity.dart';

abstract class SeismicPlaybackRepository {
  Future<List<EarthquakePgaEntity>> getEarthquakePgaData(String eventId);
}
