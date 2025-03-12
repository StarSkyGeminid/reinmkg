import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetSunData extends UseCase<CelestialEntity, LocationEntity> {
  final CelestialRepository _repository;

  GetSunData(this._repository);

  @override
  Future<Either<Failure, CelestialEntity>> call({LocationEntity? params}) {
    return _repository.getCurrentSunPosition(
      params!.time!,
      params.latitude!,
      params.longitude!,
    );
  }
}
