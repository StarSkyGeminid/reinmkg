import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:location/location.dart';

import '../../domain.dart';

abstract class LocationRepository {
  Future<Either<Failure, LocationEntity>> getNearestLocation(
      double latitude, double longitude);

  Future<LocationData?> getCurrentCoordinate();

  Future<Either<Failure, LocationEntity>> getCurrentLocation();
}
