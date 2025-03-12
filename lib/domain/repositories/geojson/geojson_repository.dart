import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';

abstract class GeojsonRepository {
  Future<Either<Failure, String>> getFaultLine();

  Future<Either<Failure, String>> getProvinceBorder();

  Future<Either<Failure, String>> getMaritimeBoundaries();
}
