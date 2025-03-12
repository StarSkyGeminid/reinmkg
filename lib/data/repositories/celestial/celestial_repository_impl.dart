// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:reinmkg/core/error/failure.dart';
import 'package:reinmkg/domain/entities/celestial/celestial_entity.dart';

import '../../../domain/repositories/celestial/celestial_repository.dart';
import '../../../utils/helper/common.dart';
import '../../datasources/local/celestial/celestial_calculator.dart';
import '../../models/celestial/celestial_model.dart';

class CelestialRepositoryImpl implements CelestialRepository {
  final CelestialCalculator _celestialCalculator;

  CelestialRepositoryImpl(this._celestialCalculator);

  @override
  Future<Either<Failure, CelestialEntity>> getCurrentMoonPosition(
      DateTime date, double latitude, double longitude) async {
    try {
      final position =
          _celestialCalculator.moon.getPosition(date, latitude, latitude);
      final times =
          _celestialCalculator.moon.getTimes(date, latitude, longitude);

      log.d(times);

      return Right(CelestialModel(
        azimuth: position['azimuth'],
        altitude: position['altitude'],
        illumination: times['illumination']['fraction'] ?? 0,
        riseTime: times['rise']?['time'],
        setTime: times['set']?['time'],
        phaseAngle: times['illumination']['phase'] ?? 0,
      ));
    } catch (e) {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, CelestialEntity>> getCurrentSunPosition(
      DateTime date, double latitude, double longitude) async {
    try {
      final position =
          _celestialCalculator.sun.getPosition(date, latitude, latitude);
      final times =
          _celestialCalculator.sun.getTimes(date, latitude, longitude);

      return Right(CelestialModel(
        azimuth: position['azimuth'],
        altitude: position['altitude'],
        riseTime: times['sunrise'],
        setTime: times['sunset'],
      ));
    } catch (e) {
      return Left(NoDataFailure());
    }
  }
}
