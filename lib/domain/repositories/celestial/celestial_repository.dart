import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/celestial/celestial.dart';

abstract class CelestialRepository {
  Future<Either<Failure, CelestialEntity>> getCurrentMoonPosition(
      DateTime dateTime, double latitude, double longitude);

  Future<Either<Failure, CelestialEntity>> getCurrentSunPosition(
      DateTime dateTime, double latitude, double longitude);
}
