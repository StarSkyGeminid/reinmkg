import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetMoonData extends UseCase<CelestialEntity, LocationEntity> {
  final CelestialRepository _repository;

  GetMoonData(this._repository);

  @override
  Future<Either<Failure, CelestialEntity>> call({LocationEntity? params}) {
    return _repository.getCurrentMoonPosition(
      params!.time!,
      params.latitude!,
      params.longitude!,
    );
  }
}
