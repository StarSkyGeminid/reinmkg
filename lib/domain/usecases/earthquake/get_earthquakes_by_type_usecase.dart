import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetEarthquakesByTypeUsecase
    extends UseCase<List<EarthquakeEntity>, EarthquakesType> {
  final EarthquakeRepository _repository;

  GetEarthquakesByTypeUsecase(this._repository);

  @override
  Future<Either<Failure, List<EarthquakeEntity>>> call(
      {EarthquakesType? params}) {
    return _repository.getEarthquakesByType(params!);
  }
}
