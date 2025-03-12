import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';

import '../../domain.dart';

abstract class EarthquakeRepository {
  Future<Either<Failure, EarthquakeEntity>> getLastEarthquakeFelt();

  Future<Either<Failure, EarthquakeEntity>> getRecentEarthquake();

  Future<Either<Failure, List<EarthquakeEntity>>> getOneWeekEarthquakes();

  Future<Either<Failure, List<EarthquakeEntity>>> getEarthquakeHistories();

  Future<Either<Failure, List<EarthquakeEntity>>> getListEarthquakesFelt();

  Future<Either<Failure, List<EarthquakeEntity>>> getEarthquakesByType(
    EarthquakesType type,
  );

  void setSelectedEarthquake(EarthquakeEntity earthquakeEntity);

  Stream<EarthquakeEntity> streamSelectedEarthquake();

  Stream<EarthquakeEntity> streamLastEarthquakeFelt();

  Stream<EarthquakeEntity> streamRecentEarthquake();
}
