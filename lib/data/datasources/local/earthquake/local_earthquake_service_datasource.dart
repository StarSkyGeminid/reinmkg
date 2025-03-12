import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/error/failure.dart';
import 'package:reinmkg/data/data.dart';

abstract class LocalEarthquakeService {
  Future<Either<Failure, EarthquakeModel>> getLastEarthquakeFelt();

  Future<Either<Failure, EarthquakeModel>> getRecentEarthquake();

  Future<Either<Failure, List<EarthquakeModel>>> getOneWeekEarthquakes();

  Future<Either<Failure, List<EarthquakeModel>>> getListEarthquakesFelt();

  Future<void> replaceOneWeekEarthquake(List<EarthquakeModel> earthquakes);

  Future<void> replaceLastEarthquakeFelt(List<EarthquakeModel> earthquakes);
}

class LocalEarthquakeServiceImpl implements LocalEarthquakeService {
  final AppDatabase _appDatabase;

  LocalEarthquakeServiceImpl(this._appDatabase);

  @override
  Future<Either<Failure, EarthquakeModel>> getLastEarthquakeFelt() async {
    try {
      final earthquake =
          await _appDatabase.earthquakeDAO.getLastEarthquakeFelt();

      if (earthquake == null) return Left(CacheFailure());

      return Right(earthquake);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, EarthquakeModel>> getRecentEarthquake() async {
    try {
      final earthquake =
          await _appDatabase.earthquakeDAO.getRecentEarthquake();

      if (earthquake == null) return Left(CacheFailure());

      return Right(earthquake);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<EarthquakeModel>>>
      getListEarthquakesFelt() async {
    try {
      final earthquakes =
          await _appDatabase.earthquakeDAO.getListEarthquakesFelt();

      if (earthquakes == null) return Left(CacheFailure());

      return Right(earthquakes);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<EarthquakeModel>>>
      getOneWeekEarthquakes() async {
    try {
      final earthquakes =
          await _appDatabase.earthquakeDAO.getOneWeekEarthquakes();

      if (earthquakes == null) return Left(CacheFailure());

      return Right(earthquakes);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> replaceLastEarthquakeFelt(
      List<EarthquakeModel> earthquakes) async {
    await _appDatabase.earthquakeDAO.deleteEarthquakeFelt();

    await _appDatabase.earthquakeDAO.insertEarthquakes(earthquakes);
  }

  @override
  Future<void> replaceOneWeekEarthquake(
      List<EarthquakeModel> earthquakes) async {
    await _appDatabase.earthquakeDAO.deleteOneWeekEarthquakes();

    await _appDatabase.earthquakeDAO.insertEarthquakes(earthquakes);
  }
}
