import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetCurrentLocation extends UseCase<LocationEntity, void> {
  final LocationRepository _repository;

  GetCurrentLocation(this._repository);

  @override
  Future<Either<Failure, LocationEntity>> call({void params}) {
    return _repository.getCurrentLocation();
  }
}
