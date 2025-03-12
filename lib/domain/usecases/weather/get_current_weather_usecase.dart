import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetCurrentWeather extends UseCase<WeatherEntity, String> {
  final WeatherRepository _repository;

  GetCurrentWeather(this._repository);

  @override
  Future<Either<Failure, WeatherEntity>> call({String? params}) {
    return _repository.getCurrentWeather(params!);
  }
}
