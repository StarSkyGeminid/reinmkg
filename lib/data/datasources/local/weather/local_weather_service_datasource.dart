import 'package:dartz/dartz.dart';
import 'package:reinmkg/utils/helper/common.dart';

import '../../../../core/core.dart';
import '../../../data.dart';

abstract class LocalWeatherService {
  Future<Either<Failure, WeatherModel>> getCurrentWeather();

  Future<Either<Failure, List<WeatherModel>>> getWeeklyWeathers();

  Future<Either<Failure, List<DailyWeatherModel>>> getDailyWeathers();

  Future<void> replaceWeathers(List<WeatherModel> listWeatherModel);

  Future<void> replaceDailyWeathers(List<DailyWeatherModel> listWeatherModel);
}

class LocalWeatherServiceImpl implements LocalWeatherService {
  final AppDatabase _appDatabase;

  LocalWeatherServiceImpl(this._appDatabase);

  @override
  Future<Either<Failure, WeatherModel>> getCurrentWeather() async {
    try {
      final weathers = await _appDatabase.weatherDAO
          .getCurrentWeather(_getNowSubtractedEpoch());
      log.d(weathers);

      if (weathers == null) return Left(CacheFailure());

      return Right(weathers);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<DailyWeatherModel>>> getDailyWeathers() async {
    try {
      final weathers = await _appDatabase.dailyWeatherDAO
          .getDailyWeathers(_getNowSubtractedEpoch());

      if (weathers == null) return Left(CacheFailure());

      return Right(weathers);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<WeatherModel>>> getWeeklyWeathers() async {
    try {
      final weathers =
          await _appDatabase.weatherDAO.getWeathers(_getNowSubtractedEpoch());

      if (weathers == null) return Left(CacheFailure());

      return Right(weathers);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> replaceWeathers(List<WeatherModel> listWeatherModel) async {
    return _appDatabase.weatherDAO.deleteWeather().then((_) {
      return _appDatabase.weatherDAO.insertWeathers(listWeatherModel);
    });
  }

  @override
  Future<void> replaceDailyWeathers(
      List<DailyWeatherModel> listDailyWeatherModel) async {
    return _appDatabase.dailyWeatherDAO.deleteDailyWeather().then((_) {
      return _appDatabase.dailyWeatherDAO
          .insertDailyWeathers(listDailyWeatherModel);
    });
  }

  int _getNowSubtractedEpoch() {
    return DateTime.now()
        .subtract(const Duration(minutes: 59))
        .millisecondsSinceEpoch;
  }
}
