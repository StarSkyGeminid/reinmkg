import '../entities/location_entity.dart';

abstract class LocationRepository {
  Future<LocationEntity> getCurrentLocation();

  Future<LocationEntity> getLastLocation();
  
  Future<LocationEntity> refreshLocation();
}
