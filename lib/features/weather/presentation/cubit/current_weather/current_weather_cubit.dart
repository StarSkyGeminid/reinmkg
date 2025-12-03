import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reinmkg/features/general/location/domain/usecases/get_current_location_usecase.dart';

import '../../../domain/entities/weather_entity.dart';
import '../../../domain/usecases/get_current_weather_usecase.dart';

part 'current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  final GetCurrentWeatherUsecase _getCurrentWeatherUsecase;
  final GetCurrentLocationUsecase _getCurrentLocationUsecase;

  CurrentWeatherCubit(
    this._getCurrentWeatherUsecase,
    this._getCurrentLocationUsecase,
  ) : super(CurrentWeatherInitial());

  Future<void> getCurrentWeather() async {
    try {
      emit(CurrentWeatherLoading());

      final location = await _getCurrentLocationUsecase.call();
      final locationId = location.administration?.adm4;

      if (locationId == null) {
        throw Exception('Invalid location ID');
      }

      final weather = await _getCurrentWeatherUsecase.call(locationId);
      emit(CurrentWeatherLoaded(weather));
    } catch (e) {
      emit(CurrentWeatherFailure('Failed to fetch current weather'));
    }
  }
}
