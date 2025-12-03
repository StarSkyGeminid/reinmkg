import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reinmkg/features/general/location/domain/usecases/get_current_location_usecase.dart';

import '../../../domain/entities/weather_entity.dart';
import '../../../domain/usecases/get_weekly_weather_usecase.dart';

part 'weekly_weather_state.dart';

class WeeklyWeatherCubit extends Cubit<WeeklyWeatherState> {
  final GetWeeklyWeatherUsecase _getWeeklyWeatherUsecase;
  final GetCurrentLocationUsecase _getCurrentLocationUsecase;

  WeeklyWeatherCubit(
    this._getWeeklyWeatherUsecase,
    this._getCurrentLocationUsecase,
  ) : super(WeeklyWeatherInitial());

  Future<void> getWeeklyWeather() async {
    try {
      emit(WeeklyWeatherLoading());
      final location = await _getCurrentLocationUsecase.call();
      final locationId = location.administration?.adm4;

      if (locationId == null) {
        throw Exception('Invalid location ID');
      }

      final weathers = await _getWeeklyWeatherUsecase.call(locationId);
      emit(WeeklyWeatherLoaded(weathers));
    } catch (e) {
      emit(WeeklyWeatherFailure('Failed to fetch weekly weather'));
    }
  }
}
