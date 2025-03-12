import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reinmkg/domain/domain.dart';

import '../../../../core/enumerate/bloc_state.dart';

part 'daily_weather_state.dart';
part 'daily_weather_cubit.freezed.dart';

class DailyWeatherCubit extends Cubit<DailyWeatherState> {
  final GetDailyWeathers _getDailyWeathersUsecase;

  DailyWeatherCubit(this._getDailyWeathersUsecase)
      : super(const DailyWeatherState());

  Future<void> getDailyWeathers(String locationId) async {
    emit(state.copyWith(status: BlocState.loading));

    final result = await _getDailyWeathersUsecase(params: locationId);

    result.fold(
      (l) => emit(
        state.copyWith(
            status: BlocState.failure,
            message: 'Tidak dapat mendapatkan cuaca harian'),
      ),
      (r) => emit(state.copyWith(
        status: BlocState.success,
        weathers: r,
      )),
    );
  }
}
