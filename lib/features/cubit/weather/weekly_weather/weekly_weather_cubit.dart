import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reinmkg/domain/domain.dart';

import '../../../../core/enumerate/bloc_state.dart';

part 'weekly_weather_state.dart';
part 'weekly_weather_cubit.freezed.dart';

class WeeklyWeatherCubit extends Cubit<WeeklyWeatherState> {
  final GetWeeklyWeathers _getWeeklyWeathersUsecase;

  WeeklyWeatherCubit(this._getWeeklyWeathersUsecase)
      : super(const WeeklyWeatherState());

  Future<void> getWeeklyWeathers(String locationId) async {
    emit(state.copyWith(status: BlocState.loading));

    final result = await _getWeeklyWeathersUsecase(params: locationId);

    result.fold(
        (l) => emit(state.copyWith(
              status: BlocState.failure,
              message: 'Tidak dapat mendapatkan cuaca mingguan',
            )),
        (r) => emit(state.copyWith(
              status: BlocState.success,
              weathers: r,
            )));
  }
}
