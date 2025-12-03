import '../entities/earthquake_entity.dart';
import '../enumerates/earthquakes_type.dart';

abstract class EarthquakeRepository {
  Future<EarthquakeEntity> getLastEarthquakeFelt();

  Future<EarthquakeEntity> getRecentEarthquake();

  Future<List<EarthquakeEntity>> getOneWeekEarthquakes();

  Future<List<EarthquakeEntity>> getEarthquakeHistories();

  Future<List<EarthquakeEntity>> getListEarthquakesFelt();

  Future<List<EarthquakeEntity>> getEarthquakesByType(EarthquakesType type);

  void setSelectedEarthquake(EarthquakeEntity earthquakeEntity);

  Stream<EarthquakeEntity> watchSelectedEarthquake();

  Stream<EarthquakeEntity> watchLastEarthquakeFelt();

  Stream<EarthquakeEntity> watchRecentEarthquake();
}
