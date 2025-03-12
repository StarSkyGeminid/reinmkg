import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetRecentEarthquake extends UseCase<EarthquakeEntity, void> {
  final EarthquakeRepository _repository;

  GetRecentEarthquake(this._repository);

  @override
  Future<Either<Failure, EarthquakeEntity>> call({void params}) {
    return _repository.getRecentEarthquake();
  }
}
