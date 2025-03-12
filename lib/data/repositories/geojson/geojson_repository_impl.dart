import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/error/failure.dart';
import 'package:reinmkg/domain/domain.dart';

import '../../datasources/local/geojson/geojson.dart';

class GeojsonRepositoryImpl implements GeojsonRepository {
  final LocalGeojsonService _localGeojsonService;

  GeojsonRepositoryImpl(this._localGeojsonService);

  @override
  Future<Either<Failure, String>> getFaultLine() {
    return _localGeojsonService.getFaultLine();
  }

  @override
  Future<Either<Failure, String>> getProvinceBorder() {
    return _localGeojsonService.getProviceBorder();
  }

  @override
  Future<Either<Failure, String>> getMaritimeBoundaries() {
    return _localGeojsonService.getMaritimeBoundaries();
  }
}
