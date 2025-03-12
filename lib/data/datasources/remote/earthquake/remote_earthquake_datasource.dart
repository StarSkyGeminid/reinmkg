import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';

import '../../../models/earthquake/earthquake_model.dart';

abstract class RemoteEarthquakeService {
  Future<Either<Failure, EarthquakeModel>> getLastEarthquakeFelt();

  Future<Either<Failure, EarthquakeModel>> getRecentEarthquake();

  Future<Either<Failure, List<EarthquakeModel>>> getOneWeekEarthquake();

  Future<Either<Failure, List<EarthquakeModel>>> getListEarthquakesFelt();

  Future<Either<Failure, List<EarthquakeModel>>> getEarthquakesByType(
      EarthquakesType type);
}
