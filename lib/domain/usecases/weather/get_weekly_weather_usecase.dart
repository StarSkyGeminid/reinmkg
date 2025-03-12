import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetWeeklyWeathers extends UseCase<List<WeatherEntity>, String> {
  final WeatherRepository _weatherRepRepository;

  GetWeeklyWeathers(this._weatherRepRepository);

  @override
  Future<Either<Failure, List<WeatherEntity>>> call({String? params}) {
    return _weatherRepRepository.getWeeklyWeathers(params!);
  }
}
