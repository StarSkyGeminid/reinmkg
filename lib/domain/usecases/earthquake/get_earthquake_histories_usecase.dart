import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetEarthquakeHistories extends UseCase<List<EarthquakeEntity>, void> {
  final EarthquakeRepository _repository;

  GetEarthquakeHistories(this._repository);

  @override
  Future<Either<Failure, List<EarthquakeEntity>>> call({void params}) {
    return _repository.getEarthquakeHistories();
  }
}
