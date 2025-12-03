import '../entities/entities.dart';
import '../enumerate/radar_type.dart';

abstract class RadarRepository {
  Future<List<RadarEntity>> getAll();

  Future<RadarEntity> getNearest(double latitude, double longitude);

  Future<List<RadarEntity>> searchRadars(String query);

  Future<void> setRadar(RadarEntity radar);

  Future<void> setType(RadarType type);

  Stream<List<RadarImageEntity>> watchRadarImages();

}
