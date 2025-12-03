import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reinmkg/features/general/location/domain/usecases/get_current_location_usecase.dart';

import '../../../domain/entities/daily_weather_entity.dart';
import '../../../domain/usecases/get_daily_weather_usecase.dart';

part 'daily_weather_state.dart';

class DailyWeatherCubit extends Cubit<DailyWeatherState> {
  final GetDailyWeatherUsecase _getDailyWeatherUsecase;
  final GetCurrentLocationUsecase _getCurrentLocationUsecase;

  DailyWeatherCubit(
    this._getDailyWeatherUsecase,
    this._getCurrentLocationUsecase,
  ) : super(DailyWeatherInitial());

  Future<void> getDailyWeather() async {
    try {
      emit(DailyWeatherLoading());
      final location = await _getCurrentLocationUsecase.call();
      final locationId = location.administration?.adm4;

      if (locationId == null) {
        throw Exception('Invalid location ID');
      }

      final weathers = await _getDailyWeatherUsecase.call(locationId);
      emit(DailyWeatherLoaded(weathers));
    } catch (e) {
      emit(DailyWeatherFailure('Failed to fetch daily weather'));
    }
  }
}
