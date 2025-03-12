import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetOneWeekEarthquakes extends UseCase<List<EarthquakeEntity>, void> {
  final EarthquakeRepository _repository;

  GetOneWeekEarthquakes(this._repository);

  @override
  Future<Either<Failure, List<EarthquakeEntity>>> call({void params}) {
    return _repository.getOneWeekEarthquakes();
  }
}
