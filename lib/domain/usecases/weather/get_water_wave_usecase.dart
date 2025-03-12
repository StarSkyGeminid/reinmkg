import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetWaterWave extends UseCase<List<WaterWaveEntity>, void> {
  final WeatherRepository _repository;

  GetWaterWave(this._repository);

  @override
  Future<Either<Failure, List<WaterWaveEntity>>> call({void params}) {
    return _repository.getWaterWave();
  }
}
