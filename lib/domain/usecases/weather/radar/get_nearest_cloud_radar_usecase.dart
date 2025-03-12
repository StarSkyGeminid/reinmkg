import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetNearestCloudRadar extends UseCase<RadarEntity, LatLng> {
  final RadarRepository _repository;

  GetNearestCloudRadar(this._repository);

  @override
  Future<Either<Failure, RadarEntity>> call({LatLng? params}) {
    return _repository.getNearestRadarImage(params!);
  }
}
