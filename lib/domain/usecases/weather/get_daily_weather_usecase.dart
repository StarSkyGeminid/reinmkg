import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetDailyWeathers extends UseCase<List<DailyWeatherEntity>, String> {
  final WeatherRepository _weatherRepRepository;

  GetDailyWeathers(this._weatherRepRepository);

  @override
  Future<Either<Failure, List<DailyWeatherEntity>>> call({String? params}) {
    return _weatherRepRepository.getDailyWeathers(params!);
  }
}
