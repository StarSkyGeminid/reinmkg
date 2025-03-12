import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../domain/domain.dart';

part 'current_weather_state.dart';
part 'current_weather_cubit.freezed.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  final GetCurrentWeather _getCurrentWeatherUsecase;

  CurrentWeatherCubit(this._getCurrentWeatherUsecase)
      : super(const CurrentWeatherState());

  Future<void> getCurrentWeather(String locationId) async {
    emit(state.copyWith(status: BlocState.loading));

    final result = await _getCurrentWeatherUsecase(params: locationId);

    result.fold(
      (l) => emit(state.copyWith(
        status: BlocState.failure,
        message: 'Tidak dapat mendapatkan cuaca',
      )),
      (r) => emit(state.copyWith(status: BlocState.success, weather: r)),
    );
  }
}
